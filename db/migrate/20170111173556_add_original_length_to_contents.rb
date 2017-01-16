class AddOriginalLengthToContents < ActiveRecord::Migration
  def change
    add_column :contents, :original_length, :integer
  end
end
