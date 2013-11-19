class Guardians::StudentsController < Guardians::BaseController
  def show
    @student = current_guardian.students.find(params[:id])
    @number = params[:number].nil? ? 3 : params[:number].to_i
    @student_actions = @student.student_actions.where('date > ?', (Date.today - @number))
  end
end
