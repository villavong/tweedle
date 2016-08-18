class CommentsController < ApplicationController
    before_action :find_post, only: [:create, :edit, :update, :destroy, :show]
    before_filter :require_permission, only: [:edit, :update, :destroy, :show]
    before_filter :authenticate_user!, only: [:create, :edit, :update, :destroy, :show]


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
    def show

      # why is this becoming a way to delete
      @comment = @post.comments.find(params[:id])
      @comment.destroy
      respond_to do |format|
        format.html { redirect_to post_path(@post), notice: 'Comment was successfully destroyed.' }
        format.json { head :no_content }
      end
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
