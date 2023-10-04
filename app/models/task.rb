class Task < ApplicationRecord
  has_many :assignments
  has_many :users, through: :assignments
  has_many_attached :files

  validates :title, presence: true
  validates :description, presence: true
  validates :files, blob: { content_type: ['image/png','image/jpg','image/jpeg','application/pdf'], size_range: 0..(5.megabytes) }

  enum importance: { low: 0, medium: 1, high: 2 }
  enum status: { todo: 0, progress: 1, done: 2 }
end
