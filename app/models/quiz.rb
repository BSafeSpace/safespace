class Quiz < ActiveRecord::Base
	belongs_to :user
	validates :answer1, presence: true, inclusion: { in: %w(Brainstorm\ Solutions\ and\ Don’t\ Judge), message: 'incorrect answer' }
	validates :answer2, presence: true, inclusion: { in: %w(Block\ a\ student:\ If\ a\ student\ is\ blocked\ 3\ times,\ they\ are\ permanently\ deleted\ from\ SafeSpace.), message: 'incorrect answer' }
	validates :answer3, presence: true, inclusion: { in: %w(True), message: 'incorrect answer' }
	validates :answer4, presence: true, inclusion: { in: %w(True), message: 'incorrect answer' }
end
	