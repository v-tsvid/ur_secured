class AnalyzingWorker
  include Sidekiq::Worker

  def perform(code)
    Api::V1::AnalyzingService.new(code).call
    # conn = Faraday.new "https://ur-secured-analyzer.herokuapp.com" 
          
    # answer = conn.post do |req|
    #   req.url '/api/analyze/'
    #   req.headers['Content-Type'] = 'application/json'
    #   req.body = "{ \"code\": #{code} }"
    # end
  end
end
