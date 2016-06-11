class CommentsController < ApplicationController
    before_action :find_post, only: [:create, :edit, :update, :destroy]
    before_filter :require_permission, only: [:edit, :update, :destroy]


    def create
      @post = Post.find(params[:post_id])

      @comment = @post.comments.create(params[:comment].permit(:comment))
      @comment.user = current_user if current_user
      @comment.save

      if @comment.save
        redirect_to post_path(@post)
      else
        render 'new'
      end
    end

    def destroy
      @comment = @post.comments.find(params[:id])
      @comment.destroy
      redirect_to post_path(@post)
    end
    def edit
      @comment = @post.comments.find(params[:id])
    end

    def update
      @comment = @post.comments.find(params[:id])

      if @comment.update(params[:comment].permit(:comment))
        redirect_to post_path(@post)
      else
        render 'edit'
      end
    end

    private
    def find_post
      @post = Post.find(params[:post_id])
    end
    def require_permission
      @comment = Comment.find(params[:id])
      if current_user.id != @comment.user_id
        redirect_to root_path, notice: "Sorry, you're not allowed"
      end

    end


end
