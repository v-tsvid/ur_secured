class Api::V1::ResultUpdatingService
  def initialize(analysis)
    @analysis = analysis
    @result = nil
  end

  def call
    return unless @analysis.result == nil
    @result = get_result
    return if @result == nil
    update_analysis
    update_url
    update_client_counters
  end

  private

    def get_result
      results = @analysis.contents.map { |content| content.safe? }
    
      if results.include? nil
        nil 
      elsif results.include? false
        false
      else
        true
      end
    end

    def update_analysis
      @analysis.update(result: @result)
    end

    def update_url
      Url.find_by_id(@analysis.url_id).update(safe?: @result)
    end

    def update_client_counters
      client = ApiClient.find_by_id(@analysis.api_client_id)
      attr_to_update = @result ? :safe_count : :unsafe_count
      client.update(attr_to_update => client.public_send(attr_to_update) + 1)
    end
end