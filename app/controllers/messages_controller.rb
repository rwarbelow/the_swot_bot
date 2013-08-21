class MessagesController < ApplicationController

  def new
    @message = Message.new
    if current_guardian?
      @recipients = Teacher.all
    elsif current_student?
      @recipients = Teacher.all
    elsif current_teacher?
      @recipients = Teacher.all + Guardian.all + Student.all
    end
  end

  def create
  	@message = Message.create(:author_id => current_user.id, :target_id => (Identity.find_by_teacher_id(params[:message][:to]).id), :body => params[:message][:body], :subject => params[:message][:subject])
  	if @message.save
      redirect_to messages_path
    else
      flash[:errors] = @message.errors.full_messages
      render 'messages/new'
    end
  end

  def index
    @message = Message.new
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


