class Task < ApplicationRecord
  after_initialize :set_default_importance, if: :new_record?
  after_initialize :set_default_status, if: :new_record?

	validates :title, presence: true
  validates :description, presence: true

  enum importance: %i[unimportant medium important]
  enum status: %i[todo progress done]

  def set_default_importance
    self.role ||= :user
  end

  def set_default_status
    self.role ||= :user
  end
end
