class CreateApiClientsUrls < ActiveRecord::Migration
  def change
    create_table :api_clients_urls, id: false do |t|
      t.belongs_to :api_client, index: true
      t.belongs_to :url, index: true
    end
  end
end
