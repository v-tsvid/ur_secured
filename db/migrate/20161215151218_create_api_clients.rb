class CreateApiClients < ActiveRecord::Migration
  def change
    create_table :api_clients do |t|
      t.string   :access_token
      t.datetime :expires_at
      t.integer  :safe_count
      t.integer  :unsafe_count

      t.timestamps null: false
    end
  end
end
