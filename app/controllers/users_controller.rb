class UsersController <ApplicationController
before_action :authenticate_user!, except: [:index, :show]
before_action :authenticate_user!, except: [:index]
before_action :check_mentor, only: [:show]
before_action :set_user, except: [:index, :show]
	def index

		@search = User.ransack(params[:q])



		@results = @search.result.paginate(:page => params[:page], :per_page => 50)

		@arrUsers = @results.order("last_sign_in_at DESC").to_a.uniq




		@revisers = Reviser.all

		@posts = Post.all.order("created_at DESC")
		@boards = Board.all

		# @user = @search.result.order("created_at DESC").to_a.uniq




		# respond_to do |format|
    #   format.html
    #   format.js
    # end


		# @country = User.uniq.pluck(:country)
		# @city = User.uniq.pluck(:city)
		# @school = User.uniq.pluck(:school)
		# @major = User.uniq.pluck(:major)

	end


def paypal_verification
	# @verification = @user.verification.new
	@user = current_user
	@verification = current_user.verification

# @verification = Verification.create(params[:verification])
	@user.verification = @verification
end



	def show

		@user = User.find(params[:id])

		@users = User.all
		@revisers = @user.revisers.all
		@languages = @user.languages.all
		@spcialties = @user.specialties.all
		#
		# @booked = Reservation.where("reviser_id = ? AND user_id = ?", @reviser.id, current_user.id).present? if current_user
		#
		# @reviews = @reviser.reviews



	end

	private
		def check_mentor
			if User.find(params[:id]).state == "mentor" || current_user == User.find(params[:id])

			else
				respond_to do |format|
		      format.html { redirect_to "/users?utf8=✓&q%5Bcountry_cont%5D=&q%5Bcity_cont%5D=&q%5Bschool_cont%5D=&q%5Bmajor_cont%5D=&commit=Search", notice: '멘티의 프로필은 공개되지 않습니다 :)' }
		      format.json { head :no_content }
		    end
			end
		end
    def set_user
      @user = User.find(params[:id])
    end

end
