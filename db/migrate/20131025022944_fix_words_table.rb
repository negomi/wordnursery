class FixWordsTable < ActiveRecord::Migration
  def change
    add_column :words, :attribution, :string
    remove_column :words, :example
  end
end
