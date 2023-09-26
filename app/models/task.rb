class Task < ApplicationRecord
  belongs_to :user, inverse_of: :tasks

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
