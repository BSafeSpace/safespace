class RecommendationsController < ApplicationController

	def index
		@recommendations = Recommendation.get_unopened
	end

	def new
		@recommendation = Recommendation.new
	end

	def create
		@recommendation = Recommendation.create(recommendation_params)

		respond_to do |format|
			format.js
			format.html
		end
	end

	# Open a request and mark as pending for other peer counselors
	def update
		@recommendation = Recommendation.find params[:id]
		@peer_id = params[:peer_id]
		@recommendation.update(peer_counselor_id: current_user.id, opened: true)
		respond_to do |format|
			format.js 
		end
	end

	def resolve
		@recommendation = Recommendation.find params[:id]
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