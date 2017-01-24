class AddUrlToAnalyses < ActiveRecord::Migration
  def change
    add_reference :analyses, :url, index: true, foreign_key: true
  end
end
