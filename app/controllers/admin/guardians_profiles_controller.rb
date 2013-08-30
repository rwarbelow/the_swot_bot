class Teachers::GuardianProfilesController < Teachers::BaseController
  def new
    @guardian = Guardian.new
  end

  def create
    registration_code = params[:guardian][:registration_code]
    ccsd_id = params[:guardian][:ccsd_id]
    if student = Student.where(:registration_code => registration_code, :ccsd_id => ccsd_id).first
      @guardian = Guardian.new(params[:guardian])
      if @guardian.save
        session[:new_guardian_id] = @guardian.id
        Guardianship.create(:student_id => student.id,
                            :guardian_id => @guardian.id,
                            :relationship_to_student => params[:guardian][:relationship_to_student])
        redirect_to new_identity_path
      else
        @errors = @guardian.errors.full_messages
        flash[:errors] = @errors
        render 'new'
      end
    else
      flash[:errors] = "Registration code or Student ID invalid."
      render 'new'
    end
  end

  def edit
    @guardian = Guardian.find(params[:id])
    if @guardian && @guardian.id == current_user.guardian.id
      render 'guardians/guardians/edit'
    else
      redirect_to error_url
    end
  end
end
