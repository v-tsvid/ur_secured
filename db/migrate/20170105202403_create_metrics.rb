class CreateMetrics < ActiveRecord::Migration
  def change
    create_table :metrics do |t|
      t.references :api_client, index: true, foreign_key: true
      t.string :browser

      t.timestamps null: false
    end
  end
end
