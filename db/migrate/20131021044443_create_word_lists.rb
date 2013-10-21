class CreateWordLists < ActiveRecord::Migration
  def change
    create_table :word_lists do |t|
      t.integer :list_id
      t.integer :word_id

      t.timestamps
    end
  end
end
