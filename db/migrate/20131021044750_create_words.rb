class CreateWords < ActiveRecord::Migration
  def change
    create_table :words do |t|
      t.string :word
      t.text :definition
      t.string :pronunciation
      t.text :example

      t.timestamps
    end
  end
end
