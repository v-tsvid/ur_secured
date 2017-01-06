class CreateUrls < ActiveRecord::Migration
  def change
    create_table :urls do |t|
      t.string :url
      t.boolean :safe?

      t.timestamps null: false
    end
  end
end
