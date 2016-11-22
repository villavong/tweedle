class MessagesController < ApplicationController
  # before_action :authenticate_user!

  def new
    @chosen_recipient = User.find_by(id: params[:to].to_i) if params[:to]
  end

  def create

    recipients = User.where(id: params['recipients'])
    conversation = current_user.send_message(recipients, params[:message][:body], params[:message][:subject]).conversation
    flash[:success] = "Message has been sent!"
    redirect_to conversation_path(conversation)
    # if current_user.access == false
    #   if current_user.messages.where("created_at::date = ?", Date.today).count >= 10
    #     respond_to do |format|
    #       format.html { redirect_to premium_path, notice: 'Want to send more Messages? Become Premium member!' }
    #       format.json { head :no_content }
    #     end
    #   else
    #     conversation = current_user.send_message(recipients, params[:message][:body], params[:message][:subject]).conversation
    #     flash[:success] = "Message has been sent!"
    #     redirect_to conversation_path(conversation)
    #   end
    # else
    #   conversation = current_user.send_message(recipients, params[:message][:body], params[:message][:subject]).conversation
    #   flash[:success] = "Message has been sent!"
    #   redirect_to conversation_path(conversation)
    # end

    # @message =  current_user.send_message(recipients, params[:message][:body],params[:message][:subject])
    # if @message.receiver.messages.count >= 6
    #   respond_to do |format|
    #     format.html { redirect_to premium_path, notice: 'Want to send more Messages? Become Premium member!' }
    #     format.json { head :no_content }
    #   end
    #
    # else
    #   flash[:success] = "Message has been sent!"
    #   redirect_to conversation_path(@message)
    # end
end
end

private

  def premium


  end
