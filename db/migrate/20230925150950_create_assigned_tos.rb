class CreateAssignedTos < ActiveRecord::Migration[7.0]
  def change
    create_table :assigned_tos do |t|

      t.timestamps
    end
  end
end
