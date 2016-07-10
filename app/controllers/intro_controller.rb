class IntroController < ApplicationController
	def info
	    render "info"
	end

	def quiz
		@quiz = Quiz.new
	    render "quiz"
	end

	def liability
	    render "liability"
	end
end
