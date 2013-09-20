class Teachers::DashboardController < Teachers::BaseController
	helper_method :sort_column
  def index
  end

  def daily_summary
  	if params[:sort] == "Name" 
	  	@students = Student.includes(:identity, :student_actions).all.sort!{ |a, b| a.last_name <=> b.last_name}
	  elsif params[:sort]
	  	@students = Student.order(sort_column + " " + "desc")
	  else
	  	@students = Student.includes(:identity, :student_actions).all.sort!{ |a, b| a.last_name <=> b.last_name}
		end

  end

  private
  
  def sort_column
    Student.column_names.include?(params[:sort]) ? params[:sort] : "id"
  end


end
