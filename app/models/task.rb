class Task < ApplicationRecord
  has_and_belongs_to_many :users, join_table: :assignments

  has_many_attached :files

  after_initialize :set_default_importance, if: :new_record?
  after_initialize :set_default_status, if: :new_record?

  validates :title, presence: true
  validates :description, presence: true
  validates :files, blob: { content_type: ['image/png','image/jpg','image/jpeg','application/pdf'], size_range: 0..(5.megabytes) }

  enum importance: %i[low medium high]
  enum status: %i[todo progress done]

  def set_default_importance
    self.importance ||= :medium
  end

  def set_default_status
    self.status ||= :todo
  end
end
