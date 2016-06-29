class UsersController <ApplicationController
before_action :authenticate_user!, except: [:index, :show]
before_action :set_user, except: [:index, :show]
	def index

		@search = User.ransack(params[:q])
		@user = @search.result.order("created_at DESC").to_a.uniq



		@results = @search.result.paginate(:page => params[:page], :per_page => 20)
		@arrUsers = @results.to_a

		@revisers = Reviser.all


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
		@revisers = Reviser.all


	end

	private
    def set_user
      @user = User.find(params[:id])
    end

end
