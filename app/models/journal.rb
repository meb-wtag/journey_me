class Journal < ApplicationRecord
  
  validates :title, presence: true
  validates :description, presence: true

  has_many :journal_entries
end
