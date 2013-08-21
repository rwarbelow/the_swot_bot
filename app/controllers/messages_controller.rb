class MessagesController < ApplicationController

  def new
    @message = Message.new
    @teachers = Teacher.all
  end

  def create
  	@message = Message.create(:author_id => current_user.id, :target_id => (Identity.find_by_teacher_id(params[:message][:to]).id), :body => params[:message][:body])
  	if @message.save
      redirect_to messages_path
    else
      flash[:errors] = @message.errors.full_messages
      render 'messages/new'
    end
  end

  def index
    @received_messages = Message.where(:target_id => current_user.id)
    @sent_messages = Message.where(:author_id => current_user.id)
  end

  def destroy
    @message = Message.find(params[:id])
    @message.destroy
    flash[:success] = "Message Deleted"
    redirect_to messages_path
  end

  def show_received
    @message = Message.find(params[:id])
  end

  def show_sent
    @message = Message.find(params[:id])
  end

end


