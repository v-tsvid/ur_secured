class CreateContents < ActiveRecord::Migration
  def change
    create_table :contents do |t|
      t.string :type
      t.text :code, index: true
      t.boolean :safe?

      t.timestamps null: false
    end
  end
end
