class RecommendationsController < ApplicationController
	def create
		Recommendation.create(recommendation_params)

		respond_to do |format|
			format.js
			format.html
		end
	end

	def show

	end

	def destory

	end

	def recommendation_params
		params.require(:recommendation).permit(:user_id, :reason, :additional_info)
	end
end