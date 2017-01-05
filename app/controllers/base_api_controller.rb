class BaseApiController < ApplicationController
  before_filter :restrict_access

  private
    def restrict_access
      @api_client = nil
      ApiClient.find_each do |client|
        @api_client = client if Devise.secure_compare(
          client.access_token, params[:access_token])
      end

      head :unauthorized unless @api_client
    end
end