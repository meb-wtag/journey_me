class CreateTasks < ActiveRecord::Migration[7.0]
  def up
    create_table :tasks do |t|
      t.string :title
      t.text :description
      t.date :deadline
      t.integer :importance
      t.integer :status

      t.timestamps
    end
  end

  def down
    drop_table :tasks
  end
end
