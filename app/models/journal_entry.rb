class JournalEntry < ApplicationRecord
  belongs_to :journal, inverse_of: :journal_entries

  validates :title, presence: true
  validates :content, presence: true

  def start_time
    self.created_at
  end
end
