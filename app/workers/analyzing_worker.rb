class AnalyzingWorker
  include Sidekiq::Worker

  def perform(temp_content_id)
    temp_content = TempContent.find_by_id(temp_content_id)
    code = temp_content.code
    result = Api::V1::AnalyzingService.new('code').call
    content = Content.find_by_id(temp_content.content_id)
    content.update(safe?: result)
  end
end
