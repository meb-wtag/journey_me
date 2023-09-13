class CreateJournals < ActiveRecord::Migration[7.0]
  def up
    create_table :journals do |t|
      t.string :title, null: false, unique: true
      t.text :description, null: false

      t.timestamps
    end
  end

  def down
    drop_table :journals
  end
end
