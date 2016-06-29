class PagesController < ApplicationController



	def home
		@posts = Post.all.order("created_at DESC").limit(20)

		# @posts1 = Post.where("board_id = ?", 1).order("created_at desc").limit(5)

		# @posts2 = Post.where("board_id = ?", 2).order("created_at desc").limit(5)

		# @posts3 = Post.where("board_id = ?", 3).order("created_at desc").limit(5)
		# 		@posts4 = Post.where("board_id = ?", 4).order("created_at desc").limit(5)

		# @posts = Post.includes(:comments).order("created_at desc")




		@users = User.all
		@revisers = Reviser.all


 # @posts = Post.where("board_id = ?", find_board).order("created_at DESC").paginate(:page => params[:page], :per_page => 15)

		@boards = Board.all


	end

	def index

	end




end
