class BaseApiController < ApplicationController
  before_filter :authenticate_with_token!
  before_filter :restrict_if_expired!

  def current_client
    ApiClient.find_each do |client|
      @current_client ||= client if Devise.secure_compare(
        client.access_token, params[:id])
    end
    @current_client
  end

  private
    def authenticate_with_token!
      render json: { errors: "Not authenticated" }, 
        status: :unauthorized unless current_client
    end

    def restrict_if_expired!
      render json: { errors: "Expired" }, 
        status: :unauthorized if current_client.expires_at < DateTime.now
    end
end