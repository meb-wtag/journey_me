class CreateJournals < ActiveRecord::Migration[7.0]
  def up
    create_table :journals do |t|
      t.string :title
      t.text :description   

      t.timestamps
    end
  end

  def down
    drop_table :journals
  end
end
