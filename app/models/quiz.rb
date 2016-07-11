class Quiz < ActiveRecord::Base
	belongs_to :user
	validates :answer1, presence: true, inclusion: { in: %w(correct), message: 'Incorrect answer' }
	validates :answer2, presence: true, inclusion: { in: %w(correct), message: 'Incorrect answer' }
	validates :answer3, presence: true, inclusion: { in: %w(correct), message: 'Incorrect answer' }
	validates :answer4, presence: true, inclusion: { in: %w(correct), message: 'Incorrect answer' }
	validates :answer5, presence: true, inclusion: { in: %w(correct), message: 'Incorrect answer' }
end
