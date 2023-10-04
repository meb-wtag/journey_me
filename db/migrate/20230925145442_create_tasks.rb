class CreateTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :tasks do |t|
      t.integer :user_id, null: false, index: true, foreign_key: true #created by:
      t.string :title, null: false
      t.text :description, null: false
      t.text :content
      t.date :deadline
      t.integer :importance, null: false, default: 1
      t.integer :status, null: false, default: 0

      t.timestamps
    end
  end
end
