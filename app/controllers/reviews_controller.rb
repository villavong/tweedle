class ReviewsController < ApplicationController

def create
	@review = current_user.reviews.create(review_params)
	redirect_to @review.reviser
end

def destroy
	@review = Review.find(params[:id])	
	reviser = @review.reviser
	@review.destroy

	redirect_to reviser

end




	private
		def review_params
			params.require(:review).permit(:comment, :star, :reviser_id)
		end
end