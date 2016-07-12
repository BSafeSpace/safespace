class Quiz < ActiveRecord::Base
	belongs_to :user
	validates :answer1, presence: true, inclusion: { in: %w(correct), message: 'incorrect answer' }
	validates :answer2, presence: true, inclusion: { in: %w(correct), message: 'incorrect answer' }
	validates :answer3, presence: true, inclusion: { in: %w(correct), message: 'incorrect answer' }
	validates :answer4, presence: true, inclusion: { in: %w(correct), message: 'incorrect answer' }
	validates :answer5, presence: true, inclusion: { in: %w(correct), message: 'incorrect answer' }
end