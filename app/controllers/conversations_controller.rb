class ConversationsController < ApplicationController
    before_filter :authenticate_user!
    before_action :get_mailbox
    before_action :get_conversation, except: [:index, :empty_trash]
    before_action :get_box, only: [:index]
    before_action :autocomplete
  def index
    if @box.eql? "inbox"
      @conversations = @mailbox.inbox
    elsif @box.eql? "sent"
      @conversations = @mailbox.sentbox
    else
      @conversations = @mailbox.trash
    end

    @conversations = @conversations.paginate(page: params[:page], per_page: 10)
  end

  def show

  end
  def reply
    current_user.reply_to_conversation(@conversation, params[:body])
    flash[:success] = 'Reply sent'
    redirect_to conversation_path(@conversation)
    # if current_user.access == false
    #   if current_user.messages.where("created_at::date = ?", Date.today).count >= 10
    #     respond_to do |format|
    #       format.html { redirect_to premium_path, notice: 'Want to send more Messages? Become Premium member!' }
    #       format.json { head :no_content }
    #     end
    #   else
    #     current_user.reply_to_conversation(@conversation, params[:body])
    #     flash[:success] = 'Reply sent'
    #     redirect_to conversation_path(@conversation)
    #   end
    #
    # else
    #   current_user.reply_to_conversation(@conversation, params[:body])
    #   flash[:success] = 'Reply sent'
    #   redirect_to conversation_path(@conversation)
    # end
  end
  # def reply
  #   current_user.reply_to_conversation(@conversation, params[:body])
  #   flash[:success] = 'Reply sent'
  #   redirect_to conversation_path(@conversation)
  # end
  def destroy
    @conversation.move_to_trash(current_user)
    flash[:success] = 'The conversation was moved to trash.'
    redirect_to conversations_path
  end

  def restore
    @conversation.untrash(current_user)
    flash[:success] = 'The conversation was restored.'
    redirect_to conversations_path
  end

  def empty_trash
    @mailbox.trash.each do |conversation|
      conversation.receipts_for(current_user).update_all(deleted: true)
    end
    flash[:success] = 'Your trash was cleaned!'
    redirect_to conversations_path
  end


  def mark_as_read
    @conversation.mark_as_read(current_user)
    flash[:success] = 'The conversation was marked as read.'
    redirect_to conversations_path
  end
  private

  def get_mailbox
    @mailbox ||= current_user.mailbox
  end

  def get_conversation
    @conversation ||= @mailbox.conversations.find(params[:id])
  end

  def get_box
    if params[:box].blank? or !["inbox","sent","trash"].include?(params[:box])
      params[:box] = 'inbox'
    end
    @box = params[:box]
  end


  def autocomplete

    @search = User.ransack(params[:q])
    @user = @search.result.order("created_at DESC").to_a.uniq

    @results = @search.result
    @arrUsers = @results.to_a

  end
end
