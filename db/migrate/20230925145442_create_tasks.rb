class CreateTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :tasks do |t|
      t.integer :user_id, null: false, index: true, foreign_key: true #created by:
      t.string :title, null: false
      t.text :content, null: false
      t.date :deadline
      t.integer :importance
      t.integer :status

      t.timestamps
    end
  end
end
