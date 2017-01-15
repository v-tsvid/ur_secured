class RenameCodeInContents < ActiveRecord::Migration
  def change
    rename_column :contents, :code, :code_md5
  end
end
