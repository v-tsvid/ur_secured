class RemoveIndexFromContents < ActiveRecord::Migration
  def change
    remove_index :contents, :code_md5
  end
end
