class QuizzesController < ApplicationController
  def new
  	@quiz = Quiz.new
  end

  def create
  	@quiz = Quiz.new(quiz_params)
  	if @quiz.save
  		flash[:notice] = "Successfully answered all questions"
  		redirect_to intro_terms_of_service_path
  	else 
  		render 'new'
  	end
  end

  private

  def quiz_params
  	params.fetch(:quiz, {}).permit(:answer1, :answer2, :answer3, :answer4, :answer5)
  end
end
