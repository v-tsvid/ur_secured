class Api::V1::ApiClientsController < BaseApiController
  respond_to :json
  skip_before_filter :restrict_access, only: :create

  # pass strong params and implement form for saving client and metric objects
    
  def create
    render create_client(ApiClient.new)
  end

  alias_method :get_token, :create

  def update_expired_token
    render update_client(@api_client)
  end

  def analyze_url
  end

  private
    
    {'create': [201, 422], 'update': [200, 400]}.each do |key, val|
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