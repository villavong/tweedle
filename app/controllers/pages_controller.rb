class PagesController < ApplicationController

	before_action :authenticate_user!, except: [:home, :school_list, :about, :korea, :english, :japan, :china]


	def home

		@search = User.ransack(params[:q])


		@results = @search.result

		@arrUsers = @results.order("last_sign_in_at DESC").to_a.uniq

		@posts = Post.all.order("created_at DESC")

		# @posts1 = Post.where("board_id = ?", 1).order("created_at desc").limit(5)

		# @posts2 = Post.where("board_id = ?", 2).order("created_at desc").limit(5)

		# @posts3 = Post.where("board_id = ?", 3).order("created_at desc").limit(5)
		# 		@posts4 = Post.where("board_id = ?", 4).order("created_at desc").limit(5)

		# @posts = Post.includes(:comments).order("created_at desc")


		@schools = User.uniq.pluck(:school)
		@languages = Language.order(:language).uniq.pluck(:language)


		@users = User.all.limit(4)
		@revisers = Reviser.all



 # @posts = Post.where("board_id = ?", find_board).order("created_at DESC").paginate(:page => params[:page], :per_page => 15)

		@boards = Board.all


	end

	def school_list
		@users = User.all

			@countries = User.order(:country).uniq.pluck(:country)
			@cities = User.order(:city).uniq.pluck(:city)

			@company_names = User.yes.order(:company_name).uniq.pluck(:company_name)

			@schools = User.yes.order(:school).uniq.pluck(:school)

			@majors = User.yes.order(:major).uniq.pluck(:major)

			@languages = Language.order(:language).uniq.pluck(:language)

			@specialties = Specialty.order(:specialty).uniq.pluck(:specialty)

			@scholarships = Scholarship.order(:name).uniq.pluck(:name)
			@educations = Education.order(:education).uniq.pluck(:education)

	end

	def about
	end

	def mentor
	end

	def index
	end

	def korea
	end

	def english

	end

	def japan

	end
	def china

	end


end
