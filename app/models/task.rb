class Task < ApplicationRecord

	validates :title, presence: true
  validates :description, presence: true

  enum :importance {
  	important: 0,
  	medium: 1,
  	unimportant: 2
  }

  enum :status {
  	todo: 0,
  	in_progress: 1,
  	done: 2
  }
end
