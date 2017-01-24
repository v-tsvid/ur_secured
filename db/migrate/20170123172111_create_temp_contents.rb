class CreateTempContents < ActiveRecord::Migration
  def change
    create_table :temp_contents do |t|
      t.text :code
      t.string :code_md5
      t.integer :original_length
      t.string :content_type

      t.timestamps null: false
    end
  end
end
