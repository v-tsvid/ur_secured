class AddContentToTempContents < ActiveRecord::Migration
  def change
    add_reference :temp_contents, :content, index: true, foreign_key: true
  end
end
