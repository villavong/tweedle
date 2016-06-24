class PagesController < ApplicationController



	def home
		@posts = Post.all
		# @posts = Post.all.order("created_at DESC").limit(2)

		@posts1 = Post.where("board_id = ?", 1).order("created_at DESC").limit(5)
		#
		@posts2 = Post.where("board_id = ?", 2).order("created_at DESC").limit(5)
		#
		@posts3 = Post.where("board_id = ?", 3).order("created_at DESC").limit(5)
		@posts4 = Post.where("board_id = ?", 4).order("created_at DESC").limit(5)




	end

	def index

	end


end
