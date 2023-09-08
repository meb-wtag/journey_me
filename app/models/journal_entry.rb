class JournalEntry < ApplicationRecord
	
	belongs_to :journal

	validates :title, presence: true
  validates :content, presence: true
end
