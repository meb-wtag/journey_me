class CreateJournals < ActiveRecord::Migration[7.0]
  def up
    create_table :journals do |t|
      t.string :title, null: false
      t.text :description, null: false

      t.timestamps
    end

    add_index :journals, :title, unique: true
  end

  def down
    drop_table :journals
  end
end
