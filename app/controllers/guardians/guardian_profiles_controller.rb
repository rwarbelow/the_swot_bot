class Guardians::GuardianProfilesController < Guardians::BaseController
  
  skip_before_filter :user_auth, :only => [:new, :create]
  skip_before_filter :require_guardian, :only => [:new, :create]

  def new
    @guardian_profile = GuardianProfile.new
  end

  def create
    registration_code = params[:guardian_profile][:registration_code]
    ccsd_id = params[:guardian_profile][:ccsd_id]
    if student = StudentProfile.where(:registration_code => registration_code, :ccsd_id => ccsd_id).first 
      @guardian_profile = GuardianProfile.new(params[:guardian_profile])
      if @guardian_profile.save
        session[:guardian_profile_id] = @guardian_profile.id
        Guardianship.create(:student_profile_id => student.id, 
                            :guardian_profile_id => @guardian_profile.id, 
                            :relationship_to_student => params[:guardian_profile][:relationship_to_student])
        redirect_to new_user_identity_path
      else
        @errors = @guardian_profile.errors.full_messages
        flash[:errors] = @errors
        render 'new'
      end
    else
      flash[:errors] = "Registration code or Student ID invalid."
      render 'new'
    end
  end

  def edit
    @guardian_profile = GuardianProfile.find(params[:id])
    if @guardian_profile && @guardian_profile.id == current_user.guardian_profile.id
      render 'guardians/guardian_profiles/edit'
    else
      redirect_to error_url
    end
  end

  def update
    @guardian_profile = GuardianProfile.find(params[:id])
    if @guardian_profile.update_attributes(params[:guardian_profile])
      flash[:success] = "Profile updated"
      redirect_to guardian_profile_path(@guardian_profile)
    else
      @errors = @guardian_profile.errors.full_messages
      render 'guardians/guardian_profiles/edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User account deleted."
    redirect_to root_url
  end

  def show
    @guardian_profile = GuardianProfile.find(params[:id])
    @guardianship = Guardianship.new
  end

  def add_student
    registration_code = params[:guardianship][:registration_code]
    ccsd_id = params[:guardianship][:ccsd_id]
    @guardian_profile = GuardianProfile.find(params[:guardian_profile_id])
    if StudentProfile.exists?(:ccsd_id => ccsd_id, :registration_code => registration_code)
      student = StudentProfile.where(:registration_code => registration_code, :ccsd_id => ccsd_id).first 
      @guardianship = Guardianship.new(:student_profile_id => student.id, 
                          :guardian_profile_id => @guardian_profile.id, 
                          :relationship_to_student => params[:guardianship][:relationship_to_student])
      if @guardianship.save
        redirect_to guardian_profile_path(@guardian_profile)
      else
        @errors = @guardianship.errors.full_messages
        flash[:errors] = @errors
        render 'show'
      end
    else
      @guardianship = Guardianship.new
      flash[:errors] = "The registration code and CCSD ID you entered do not match."
      render 'guardians/guardian_profiles/show'
    end
  end

end
