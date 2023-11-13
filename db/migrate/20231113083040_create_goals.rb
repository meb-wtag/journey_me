class CreateGoals < ActiveRecord::Migration[7.0]
  def change
    create_table :goals do |t|
      t.integer :journal_entry_id, null: false, index: true, foreign_key: true
      t.string :title, null: false
      t.text :description, null: false
      t.boolean :reached?

      t.timestamps
    end
  end
end
