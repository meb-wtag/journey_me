class CreateJournalEntries < ActiveRecord::Migration[7.0]
  def up
    create_table :journal_entries do |t|
      t.integer :journal_id, :null => false, index: true, foreign_key: true
      t.string :title
      t.text :content
      t.text :goal

      t.timestamps
    end 
  end

  def down
    drop_table :journal_entries
  end
end
