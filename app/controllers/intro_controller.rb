class IntroController < ApplicationController
	def info
	    render "info"
	end

	def quiz
		@quiz = Quiz.new
	    redirect_to new_quiz_path
	end

	def liability
	    render "liability"
	end
end
