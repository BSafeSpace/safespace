class Quiz < ActiveRecord::Base
	belongs_to :user
	validates :answer1, acceptance: { accept: ['TRUE', 'answer1'], message: 'Incorrect answer' }
	validates :answer2, acceptance: { accept: ['TRUE', 'answer2'], message: 'Incorrect answer' }
	validates :answer3, acceptance: { accept: ['TRUE', 'answer3'], message: 'Incorrect answer' }
	validates :answer4, acceptance: { accept: ['TRUE', 'answer4'], message: 'Incorrect answer' }
	validates :answer5, acceptance: { accept: ['TRUE', 'answer5'], message: 'Incorrect answer' }
end
