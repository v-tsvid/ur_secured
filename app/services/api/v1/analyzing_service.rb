require 'digest/md5'
require 'zlib'
require 'base64'

class Api::V1::AnalyzingService
  def initialize(html, javascripts)
    @html = html
    @javascripts = javascripts
  end

  def call
    analyze_html(@html) && analyze_javascripts(@javascripts)
  end

  private

    def analyze_javascripts(javascripts)
      javascripts.each do |js| 
        return false unless analyze_javascript(js)
      end if javascripts.kind_of?(Array)

      return true
    end

    ['html', 'javascript'].each do |type|
      define_method "analyze_#{type}".to_sym do |code|
        code_decompressed = decompress(decode(code))
        original_length = code_decompressed.length
        code_md5 = Digest::MD5.hexdigest(code_decompressed)
        klass = type.classify.constantize
        answer = klass.get_answer_or_persist(code_md5, original_length)

        if answer.nil?
          answer = analyze_code(code_decompressed)
          klass.by_md5_and_length(
            code_md5, original_length).first.update(safe?: answer)
        end
        
        return answer
      end
    end

    def analyze_code(code)
      sleep 60
      return code.length.even? ? true : false
    end

    def decode(code)
      Base64.decode64(code.gsub("\\n", "\n").gsub(" ", "+"))
    end

    def decompress(decoded)
      Zlib::Inflate.inflate(decoded)
    end
end