class Api::V1::ApiClientsController < BaseApiController
  respond_to :json
  
  skip_before_filter :authenticate_with_token!, only: :create
  skip_before_filter :restrict_if_expired!, only: [:create, :update]

  # pass strong params and implement form for saving client and metric objects
    
  def create
    render create_client(ApiClient.new)
  end

  def show
    json_to_render = { json: { urls:         current_client_urls, 
                               safe_count:   current_client.safe_count,
                               unsafe_count: current_client.unsafe_count } }
    
    render json: json_to_render, status: 200
  end

  def update
    render update_client(current_client)
  end

  def analyze_url
  end

  private

    def current_client_urls
      current_client.urls.map { |url| { url: url.url, safe?: url.safe? } }
    end
    
    {'create': [201, 422], 
     'update': [200, 422]}.each do |key, val|
      
      define_method "hash_client_#{key}d" do |client|
        { json: { token: client.access_token }, status: val[0] }
      end

      define_method "hash_failed_to_#{key}" do |client|
        { json: { errors: client.errors }, status: val[1] }
      end

      define_method "#{key}_client" do |client|
        method_to_call = client.save ? "hash_client_#{key}d" : "hash_failed_to_#{key}"
        self.send(method_to_call.to_sym, client)
      end
    end
end