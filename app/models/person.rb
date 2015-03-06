class Person < ActiveRecord::Base

	validates :gender, presence: true, inclusion: %w(male female)
	validates :height, numericality: { greater_than: 0 }
	validates :weight, numericality: { greater_than: 0 }

end
