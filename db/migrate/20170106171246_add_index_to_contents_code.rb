class AddIndexToContentsCode < ActiveRecord::Migration
  def change
    remove_index :contents, :code
    add_index :contents, :code, unique: true, length: 200
  end
end
