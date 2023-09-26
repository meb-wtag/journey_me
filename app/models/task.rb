class Task < ApplicationRecord
  has_many :assignments
  has_many :users, through: :assignments

  after_initialize :set_default_importance, if: :new_record?
  after_initialize :set_default_status, if: :new_record?

  validates :title, presence: true
  validates :content, presence: true

  enum importance: %i[low medium high]
  enum status: %i[todo progress done]

  def set_default_importance
    self.importance ||= :medium
  end

  def set_default_status
    self.status ||= :todo
  end
end
