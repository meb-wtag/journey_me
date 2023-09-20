class Journal < ApplicationRecord
  belongs_to :user, inverse_of: :journals
  has_many :journal_entries, dependent: :destroy, inverse_of: :journal

  validates :title, presence: true
  validates :description, presence: true
end
