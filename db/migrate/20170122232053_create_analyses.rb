class CreateAnalyses < ActiveRecord::Migration
  def change
    create_table :analyses do |t|
      t.string :uid, index: true
      t.references :api_client, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
