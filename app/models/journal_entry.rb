class JournalEntry < ApplicationRecord
  belongs_to :journal, inverse_of: :journal_entries

  has_rich_text :content

  validates :title, presence: true
  validates :content, presence: true

  def start_time
    self.created_at
  end

  def end_time
    self.updated_at
  end
end
