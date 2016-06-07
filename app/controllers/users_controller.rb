class UsersController <ApplicationController

	def index

		@search = User.ransack(params[:q])
		@user = @search.result.order("created_at DESC").to_a.uniq

		@country = User.uniq.pluck(:country)
		@city = User.uniq.pluck(:city)
		@school = User.uniq.pluck(:school)
		@major = User.uniq.pluck(:major)


		@results = @search.result
		@arrUsers = @results.to_a

		@revisers = Reviser.all

	end

	





	def show
		@user = User.find(params[:id])
		@users = User.all
		@revisers = Reviser.all
		

	end

end
