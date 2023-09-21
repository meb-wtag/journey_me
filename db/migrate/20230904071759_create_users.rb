class CreateUsers < ActiveRecord::Migration[7.0]
  def up
      create_table :users do |t|
      t.string :username, null: false, uniqueness: true
      t.string :first_name
      t.string :last_name
      t.string :password_digest, null: false
      t.string :password_confirmation
      t.text :description
      t.string :email
      t.integer :mobile
      t.string :adress
      t.string :country
      t.string :city  
      t.date :date_of_birth 
      t.date :joining_date

      t.timestamps
    end
  end

  def down
    drop_table :users
  end
end
