# frozen_string_literal: true

class AlterJournals < ActiveRecord::Migration[7.0]
  def change
    add_column :journals, :user_id, :integer, null: false, index: true, foreign_key: true
  end
end
