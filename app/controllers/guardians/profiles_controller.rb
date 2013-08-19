class Guardians::GuardiansController < Guardians::BaseController
  def new
    @guardian = Guardian.new
  end

  def create
    registration_code = params[:guardian][:registration_code]
    ccsd_id = params[:guardian][:ccsd_id]
    if student = Student.where(:registration_code => registration_code, :ccsd_id => ccsd_id).first 
      @guardian = Guardian.new(params[:guardian])
      if @guardian.save
        session[:guardian_id] = @guardian.id
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

  def update
    @guardian = Guardian.find(params[:id])
    if @guardian.update_attributes(params[:guardian])
      flash[:success] = "Profile updated"
      redirect_to guardian_path(@guardian)
    else
      @errors = @guardian.errors.full_messages
      render 'guardians/guardians/edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User account deleted."
    redirect_to root_url
  end

  def show
    @guardian = Guardian.find(params[:id])
    @guardianship = Guardianship.new
  end

  def add_student
    registration_code = params[:guardianship][:registration_code]
    ccsd_id = params[:guardianship][:ccsd_id]
    @guardian = Guardian.find(params[:guardian_id])
    if Student.exists?(:ccsd_id => ccsd_id, :registration_code => registration_code)
      student = Student.where(:registration_code => registration_code, :ccsd_id => ccsd_id).first 
      @guardianship = Guardianship.new(:student_id => student.id, 
                          :guardian_id => @guardian.id, 
                          :relationship_to_student => params[:guardianship][:relationship_to_student])
      if @guardianship.save
        redirect_to guardian_path(@guardian)
      else
        @errors = @guardianship.errors.full_messages
        flash[:errors] = @errors
        render 'show'
      end
    else
      @guardianship = Guardianship.new
      flash[:errors] = "The registration code and CCSD ID you entered do not match."
      render 'guardians/guardians/show'
    end
  end

end
