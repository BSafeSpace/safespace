class Quiz < ActiveRecord::Base
	belongs_to :user
	validates :answer1, presence: true, acceptance: { accept: [true, 'TRUE', 'correct'], message: 'Incorrect answer' }
	validates :answer2, presence: true, acceptance: { accept: ['TRUE', 'correct'], message: 'Incorrect answer' }
	validates :answer3, presence: true, acceptance: { accept: ['TRUE', 'correct'], message: 'Incorrect answer' }
	validates :answer4, presence: true, acceptance: { accept: ['TRUE', 'correct'], message: 'Incorrect answer' }
	validates :answer5, presence: true, acceptance: { accept: ['TRUE', 'correct'], message: 'Incorrect answer' }
end
