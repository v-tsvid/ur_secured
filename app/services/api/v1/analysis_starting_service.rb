require 'digest/md5'
require 'zlib'
require 'base64'

class Api::V1::AnalysisStartingService
  def initialize(current_client, html, javascripts, url)
    @analysis = Analysis.new(api_client: current_client)
    @html = html
    @javascripts = javascripts
    @url = url
  end

  def call
    assign_url
    persist_contents.each do |id|
      assign_content(id)
      perform_async_job(id)
    end
    return @analysis.save ? @analysis : @analysis.errors.full_messages.join('. ')
  end

  private

    def perform_async_job(id)
      temp_content = TempContent.find_by(content_id: id)
      AnalyzingWorker.perform_async(temp_content.id) if temp_content
    end

    def assign_url
      url = Url.where(url: @url).first_or_create
      @analysis.url = url
    end

    def assign_content(id)
      @analysis.contents << Content.find_by_id(id)
    end

    def persist_contents
      array = []
      array << persist_content(@html, 'html')
      @javascripts.each do |item|
        array << persist_content(item, 'javascript')
      end
      array.compact
    end

    def persist_content(code, type)
      code_decompressed = decompress(decode(code))
      original_length = code_decompressed.length
      code_md5 = Digest::MD5.hexdigest(code_decompressed)
      klass = type.classify.constantize

      md5_content = klass.by_md5_and_length(
        code_md5, original_length).first_or_create

      if md5_content.safe? == nil
        TempContent.create(code: code, content_id: md5_content.id)&.id
      end

      return md5_content.id
    end

    def decode(code)
      Base64.decode64(code.gsub("\\n", "\n").tr(" ", "+"))
    end

    def decompress(decoded)
      Zlib::Inflate.inflate(decoded)
    end
end