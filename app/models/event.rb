class Event < ActiveRecord::Base
	validates :hostname, :org, :created, presence: true
	validate :not_in_future


	def not_in_future
		errors.add(:created, "Invalid time") unless created <= Time.now
	end
end
