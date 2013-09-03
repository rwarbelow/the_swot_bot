class Admin::GuardianProfilesController < Admin::BaseController
  def new
    @guardian = Guardian.new
  end

  def create
    registration_code = params[:guardian][:registration_code]
    ccsd_id = params[:guardian][:ccsd_id]
    if @student = Student.where(:registration_code => registration_code, :ccsd_id => ccsd_id).first
      @guardian = Guardian.new(params[:guardian])
      @identity = @guardian.build_identity(params[:identity])

      begin
        Guardian.transaction do
          @guardian.save!
          @identity.guardian_id = @guardian.id
          @identity.save!
          @guardian.reload
          @guardianship = Guardianship.create(:student_id => @student.id,
                          :guardian_id => @guardian.id,
                          :relationship_to_student => params[:guardian][:relationship_to_student])
          session[:new_guardian_id] = @guardian.id
          session[:user_id] = @identity.id
        end
        redirect_to guardians_root_path
      rescue ActiveRecord::RecordInvalid => invalid
        flash[:errors] = @guardian.errors.full_messages + @identity.errors.full_messages
        render 'new'
      end
    else
      flash[:errors] = ["Registration code or Student ID invalid."]
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
