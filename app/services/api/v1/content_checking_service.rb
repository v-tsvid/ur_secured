require 'digest/md5'
require 'zlib'
require 'base64'

class Api::V1::ContentCheckingService
  def initialize(html, javascripts)
    @html = html
    @javascripts = javascripts
  end

  def call
    analysis = Analysis.new
    persist_md5_all.each do |id|
      analysis.contents << Content.find_by_id(id)
    end
    full_ids = persist_full_all
    full_ids.each do |id|
      AnalyzingWorker.perform_async(id)
    end
    return analysis.save ? analysis.id : analysis.errors.full_messages.join('. ')
  end

  private

    def persist_full_all
      array = []
      
      array << persist_full(@html, 'html')
      @javascripts.each do |item|
        array << persist_full(item, 'javascript')
      end

      array
    end

    def persist_md5_all
      array = []
      
      array << persist_md5(@html, 'html')
      @javascripts.each do |item|
        array << persist_md5(item, 'javascript')
      end

      array
    end

    def persist_md5(code, type)
      code_decompressed = decompress(decode(code))
      original_length = code_decompressed.length
      code_md5 = Digest::MD5.hexdigest(code_decompressed)
      klass = type.classify.constantize
      klass.by_md5_and_length(code_md5, original_length).first_or_create.id
    end

    def persist_full(code, type)
      code_decompressed = decompress(decode(code))
      code_md5 = Digest::MD5.hexdigest(code_decompressed)
      original_length = code_decompressed.length
      TempContent.create(
        code: code, 
        code_md5: code_md5, 
        original_length: original_length, 
        content_type: type).id
    end

    # def check_javascripts(javascripts)
    #   javascripts.each do |js| 
    #     return false unless check_javascript(js)
    #   end if javascripts.kind_of?(Array)

    #   return true
    # end

    # ['html', 'javascript'].each do |type|
    #   define_method "check_#{type}".to_sym do |code|
    #     code_decompressed = decompress(decode(code))
    #     original_length = code_decompressed.length
    #     code_md5 = Digest::MD5.hexdigest(code_decompressed)
    #     klass = type.classify.constantize
    #     answer = klass.get_answer_or_persist(code_md5, original_length)

    #     if answer.nil?
    #       klass.by_md5_and_length(
    #         code_md5, original_length).first.update(safe?: answer)
    #     end
        
    #     return answer
    #   end
    # end

    def decode(code)
      Base64.decode64(code.gsub("\\n", "\n").tr(" ", "+"))
    end

    def decompress(decoded)
      Zlib::Inflate.inflate(decoded)
    end
end