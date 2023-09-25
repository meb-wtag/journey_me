class CreateTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :tasks do |t|
      t.integer :user_id, null: false, index: true, foreign_key: true
      t.text :description, null: false

      t.timestamps
    end
  end
end
