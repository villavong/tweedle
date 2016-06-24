class UsersController <ApplicationController

	def index

		@search = User.ransack(params[:q])
		@results = @search.result
		@arrUsers = @results.to_a
		@revisers = Reviser.all

		# @user = @search.result.order("created_at DESC").to_a.uniq

		# @country = User.uniq.pluck(:country)
		# @city = User.uniq.pluck(:city)
		# @school = User.uniq.pluck(:school)
		# @major = User.uniq.pluck(:major)

	end







	def show
		@user = User.find(params[:id])
		@users = User.all
		@revisers = @user.revisers


	end

end
