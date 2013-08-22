class Teachers::EmailController < Teachers::BaseController

  def weekly_email
      EmailHelper::weekly_email
  end

  def send_student_email
     EmailHelper::send_student_email(params[:guardian_username], params[:ccsd_id])    
  end
end
