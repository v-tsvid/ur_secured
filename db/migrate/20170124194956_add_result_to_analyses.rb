class AddResultToAnalyses < ActiveRecord::Migration
  def change
    add_column :analyses, :result, :boolean
  end
end
