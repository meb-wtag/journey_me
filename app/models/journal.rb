class Journal < ApplicationRecord
  has_many :journal_entries, dependent: :destroy, inverse_of: :journal
  
  validates :title, presence: true
  validates :description, presence: true
end
