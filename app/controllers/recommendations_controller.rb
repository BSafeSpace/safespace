class RecommendationsController < ApplicationController

	def index
		@recommendations = Recommendation.get_unopened
	end

	def new
		@recommendation = Recommendation.new
	end

	def create
		puts "**************************************"
		@recommendation = Recommendation.create(recommendation_params)
		@rec_user = @recommendation.get_user

		respond_to do |format|
			format.js
			format.html
		end
	end

	# Open a request and update the recommendation for other peer counselors
	def update
		@recommendation = Recommendation.find params[:id]
		@recommendation.update(peer_counselor_id: params[:peer_id], opened: true)
		respond_to do |format|
			format.js 
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