class PostsController < ApplicationController
  before_filter :require_permission, only: [:edit, :update, :destroy]

  before_action :find_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @posts = Post.all.order("created_at DESC").paginate(:page => params[:page], :per_page => 25)
  end

  def show
    @posts = Post.where("board_id = ?", find_board).order("created_at DESC").paginate(:page => params[:page], :per_page => 15)
@post = Post.find(params[:id])
  end

  def new
    @board = Board.find(params[:board_id])

    @post = @board.posts.build
    @post.user = current_user if current_user

  end
  def create
    @board = Board.find(params[:board_id])
    @post = @board.posts.build(post_params)
    @post.user = current_user if current_user
    if @post.save
      redirect_to board_post_path(@board, @post)
    else
      render 'new'
    end
  end
  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to post_path
    else
      render 'edit'
    end

  end


  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to root_path, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  def find_board
    @post = Post.find(params[:id])
  end
  
  def set_board
    @board = Board.find(params[:id])
  end
  def find_post
    @post = Post.find(params[:id])
  end


  def post_params
    params.require(:post).permit(:title, :content, :photo)
  end
  def require_permission
    @post = Post.find(params[:id])
    if current_user.id != @post.user_id
      redirect_to root_path, notice: "Sorry, you're not allowed"
    end

  end

end
