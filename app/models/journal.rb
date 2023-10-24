class Journal < ApplicationRecord
  belongs_to :user, inverse_of: :journals
  has_many :journal_entries, dependent: :destroy, inverse_of: :journal
  has_many_attached :files

  validates :title, presence: true
  validates :description, presence: true
  validates :files, blob: { content_type: ['image/png','image/jpg','image/jpeg','image/svg','application/pdf','video/mp4'], size_range: 0..(5.megabytes) }

  def self.ransackable_attributes(auth_object = nil)
    ["title", "description", "created_at"]
  end
end
