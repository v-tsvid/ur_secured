class AddIndexToContents < ActiveRecord::Migration
  def change
    add_index :contents, [:code_md5, :original_length, :type], unique: true
  end
end
