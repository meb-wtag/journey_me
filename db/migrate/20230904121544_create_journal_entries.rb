# frozen_string_literal: true

class CreateJournalEntries < ActiveRecord::Migration[7.0]
  def up
    create_table :journal_entries do |t|
      t.integer :journal_id, null: false, index: true, foreign_key: true
      t.string :title, null: false, unique: true
      t.text :content, null: false
      t.text :goal

      t.timestamps
    end
  end

  def down
    drop_table :journal_entries
  end
end
