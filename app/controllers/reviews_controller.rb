class ReviewsController < ApplicationController

def create
	@review = current_user.reviews.create(review_params)
	@user = User.find(params[:id])
	redirect_to @review.user
end

def destroy
	@review = Review.find(params[:id])
	reviser = @review.reviser
	@review.destroy

	redirect_to reviser

end

# def destroy
# 	@review = Review.find(params[:id])
# 	reviser = @review.reviser
# 	@review.destroy
#
# 	redirect_to reviser
#
# end




	private
	def find_user
		@user = User.find(params[:id])
	end
		def review_params
			params.require(:review).permit(:comment, :star, :reviser_id, :user_id)
		end
end
