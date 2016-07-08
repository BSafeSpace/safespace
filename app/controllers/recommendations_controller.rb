class RecommendationsController < ApplicationController

	def index
		@recommendations = Recommendation.all
	end

	def new
		@recommendation = Recommendation.new
	end

	def create
		puts "**************************************"
		Recommendation.create(recommendation_params)

		respond_to do |format|
			format.js
			format.html
		end
	end

	def show

	end

	def destroy

	end

	private 

	def recommendation_params
		params.require(:recommendation).permit(:user_id, :reason, :additional_info)
	end
end