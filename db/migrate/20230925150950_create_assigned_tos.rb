class CreateAssignedTos < ActiveRecord::Migration[7.0]
  def change
    create_table :assigned_tos do |t|
      t.references :user, null: false, foreign_key: true
      t.references :task, null: false, foreign_key: true

      t.timestamps
    end
  end
end
