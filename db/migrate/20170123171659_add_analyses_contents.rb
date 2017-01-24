class AddAnalysesContents < ActiveRecord::Migration
  def change
    create_table :analyses_contents, id: false do |t|
      t.belongs_to :analysis, index: true
      t.belongs_to :content, index: true
    end
  end
end