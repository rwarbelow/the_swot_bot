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
  	@message = Message.create(:author_id => current_user.id, :target_id => (Identity.find(params[:message][:to]).id), :body => params[:message][:body], :subject => params[:message][:subject])
  	@message.subject = "(No Subject)" if @message.subject == ""
    if @message.save
      flash[:message_sent] = "Your message has been delivered to #{Identity.find(@message.target_id).first_name} #{Identity.find(@message.target_id).last_name}!"
      redirect_to messages_path
    else
      flash[:errors] = @message.errors.full_messages
      render 'messages/new'
    end
  end

  def index
    @message = Message.new
    @received_messages = Message.where(:target_id => current_user.id).where("created_at > ?", (Date.today - 31))
    @sent_messages = Message.where(:author_id => current_user.id).where("created_at > ?", (Date.today - 31))
  end

  def destroy
    @message = Message.find(params[:id])
    @message.destroy
    flash[:success] = "Message Deleted"
    redirect_to messages_path
  end

  def show_received
    @message = Message.find(params[:id])
    if @message.target_id == current_user.id
      render '/messages/show_received'
    else
      redirect_to messages_path
    end
  end

  def show_sent
    @message = Message.find(params[:id])
    if @message.author_id == current_user.id
      render '/messages/show_sent'
    else
      redirect_to messages_path
    end
  end

end


