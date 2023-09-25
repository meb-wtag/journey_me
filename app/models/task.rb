class Task < ApplicationRecord
  has_many :assigned_tos
  has_many :users, through: :assigned_tos

  after_initialize :set_default_importance, if: :new_record?
  after_initialize :set_default_status, if: :new_record?

  validates :title, presence: true
  validates :description, presence: true

  enum importance: %i[unimportant medium important]
  enum status: %i[todo progress done]

  def set_default_importance
    self.importance ||= :user
  end

  def set_default_status
    self.status ||= :user
  end
end
