class QuizzesController < ApplicationController
  def new
  	@quiz = Quiz.new
  end

  def create
  	@quiz = Quiz.new(quiz_params)
  	
  end

  private

  def quiz_params
  	params.require(:quiz).permit(:answer1, :answer2, :answer3, :answer4, :answer5)
  end
end
