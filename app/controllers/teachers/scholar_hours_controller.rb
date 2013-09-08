class Teachers::ScholarHoursController < Teachers::BaseController

  def index
  	@new_scholar_hours = ScholarHour.where(date_assigned: Date.today, status: "Not Complete").sort! {|a, b| a.student.last_name <=> b.student.last_name}
  	@old_scholar_hours = (ScholarHour.where(status: "Not Complete") - @new_scholar_hours).sort! {|a, b| a.student.last_name <=> b.student.last_name}
  	@completed_scholar_hours = ScholarHour.where(status: "Complete").sort! {|a, b| a.student.last_name <=> b.student.last_name}
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
  	@scholarhour = ScholarHour.find(params[:id])
  	@scholarhour.delete
  	redirect_to teachers_scholar_hours_path
  end

  def update
  	@scholarhour = ScholarHour.find(params[:id])
  	@scholarhour.date_served = Date.today
  	@scholarhour.status = "Complete"
  	@scholarhour.save
  	redirect_to teachers_scholar_hours_path
  end

  def print
    @new_scholar_hours = ScholarHour.where(date_assigned: Date.today, status: "Not Complete").sort! {|a, b| a.student.last_name <=> b.student.last_name}
    @old_scholar_hours = (ScholarHour.where(status: "Not Complete") - @new_scholar_hours).sort! {|a, b| a.student.last_name <=> b.student.last_name}
    render 'teachers/scholar_hours/print', layout: false
  end
end
