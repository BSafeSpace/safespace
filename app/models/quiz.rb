class Quiz < ActiveRecord::Base
	belongs_to :user
	validates :answer1, acceptance: { accept: ['TRUE', 'answer1'] }
	validates :answer2, acceptance: { accept: ['TRUE', 'answer2'] }
	validates :answer3, acceptance: { accept: ['TRUE', 'answer3'] }
	validates :answer4, acceptance: { accept: ['TRUE', 'answer4'] }
	validates :answer5, acceptance: { accept: ['TRUE', 'answer5'] }
end
