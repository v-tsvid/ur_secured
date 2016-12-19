class Api::V1::ApiClientsController < BaseApiController
  respond_to :json

  alias_method :create, :get_token
  
  def create
    # pass strong params and implement form for saving client and metric objects
    render save_client(ApiClient.new)
  end

  def index
  end

  private

    def save_client(client)
      client.save ? hash_client_created(client) : hash_failed_to_create(client)
    end

    def hash_client_created(client)
      { token: client.access_token, status: 201 }
    end

    def hash_failed_to_create(client)
      { json: { errors: client.errors }, status: 422 }
    end
end