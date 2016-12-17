class AddIndexToApiClientsAccessToken < ActiveRecord::Migration
  def change
    add_index :api_clients, :access_token
  end
end
