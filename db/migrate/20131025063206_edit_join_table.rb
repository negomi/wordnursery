class EditJoinTable < ActiveRecord::Migration
  def change
    drop_table :lists_words
    create_table :lists_words, id: false do |t|
      t.belongs_to :list
      t.belongs_to :word
    end
  end
end
