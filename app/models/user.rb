class User < ApplicationRecord

	enum role: { admin: 0, supervisor: 1, user: 2}

	validates :first_name, :last_name, presence: true
end
