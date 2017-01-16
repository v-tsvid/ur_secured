class Api::V1::ClientDataSavingService
  def initialize(client, metric, url, answer)
    @client = client
    @url = url
    @metric = metric
    @answer = answer
    @errors = ""
  end

  def call
    @errors += save_metric
    @errors += save_url

    return @errors == "" ? true : @errors
  end

  private

    def save_metric
      metric = Metric.where(
        api_client: @client, browser: @metric['browser']).first_or_create
      return metric.errors.full_messages.join('. ')
    end

    def save_url
      url = Url.where(url: @url).first_or_create
      return url.errors.full_messages.join('. ')
    end

    # [:metric, :url].each do |item|
    #   define_method "save_#{item}".to_sym do |item|
        
    #   end
    # end
end