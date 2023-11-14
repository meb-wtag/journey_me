class Goal < ApplicationRecord
	belongs_to :journal_entry

	validates :title, presence: true
  validates :description, presence: true
end
