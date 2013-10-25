class CreateWordsListsTable < ActiveRecord::Migration
  def change
    drop_table :word_lists

    create_table :lists_words, id: false do |t|
      t.belongs_to :list_id
      t.belongs_to :word_id
    end
  end
end
