class Teachers::ScholarHoursController < Teachers::BaseController

  def index
    @completed_scholar_hours = ScholarHour.where(status: "Complete").sort! {|a, b| a.student.last_name <=> b.student.last_name}
    @students_with_scholar_hours = Student.all_with_incomplete_scholar_hours.sort! { |a, b| a.last_name <=> b.last_name }
  end

  def new
    @scholar_hour = ScholarHour.new
    @students = Student.all.sort! { |a, b| a.last_name <=> b.last_name }
  end

  def create
    params[:student_ids].each do |student_id|
      ScholarHour.create!(student_id: student_id, reason: params[:reason], date_assigned: params[:date_assigned], comments: params[:comments])
    end
    redirect_to teachers_scholar_hours_path
  end

  def generate_scholar_hour_list
  	@student_ids = ScholarHour.find_daily_student_list
  	@student_ids.each do |student|
  		id = student[0]
  		reason = student[1]
  		ScholarHour.create(:student_id => id, :reason => reason, :date_assigned => Date.today)
  	end
  	redirect_to teachers_scholar_hours_path
  end

  def destroy
  	@scholar_hour = ScholarHour.find(params[:id])
  	@scholar_hour.delete
    respond_to do |format|
      format.html { redirect_to teachers_scholar_hours_path }
      format.js 
    end
  	
  end

  def complete
  	@scholar_hour = ScholarHour.find(params[:id])
  	@scholar_hour.date_served = Date.today
  	@scholar_hour.status = "Complete"
  	@scholar_hour.save
    respond_to do |format|
      format.html { redirect_to teachers_scholar_hours_path }
      format.js
    end
  end

  def print
    @new_scholar_hours = ScholarHour.where(date_assigned: Date.today, status: "Not Complete").sort! {|a, b| a.student.last_name <=> b.student.last_name}
    @old_scholar_hours = (ScholarHour.where(status: "Not Complete") - @new_scholar_hours).sort! {|a, b| a.student.last_name <=> b.student.last_name}
    render 'teachers/scholar_hours/print', layout: false
  end

  def edit
    @scholar_hour = ScholarHour.find(params[:id])
  end

  def update
    @scholar_hour = ScholarHour.find(params[:id])
    @scholar_hour.update_attributes(params[:scholar_hour])
    @scholar_hour.save
    redirect_to teachers_scholar_hours_path
  end

  def completed_scholar_hours
    @completed_scholar_hours = ScholarHour.where(status: "Complete").sort! {|a, b| a.student.last_name <=> b.student.last_name}
  end

  def multi_complete
    params[:scholar_hour_ids].each do |s|
      @scholar_hour = ScholarHour.find(s)
      @scholar_hour.status = "Complete"
      @scholar_hour.date_served = Date.today
      @scholar_hour.save
    end
    redirect_to teachers_scholar_hours_path
  end
end
