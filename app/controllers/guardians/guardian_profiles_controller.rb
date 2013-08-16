class Guardians::GuardianProfilesController < Guardians::BaseController
  
  skip_before_filter :user_auth, :only => [:new, :create]
  skip_before_filter :require_guardians, :only => [:new, :create]

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
    end
  end

  def edit
    @guardian_profile = GuardianProfile.find(params[:id])
  end

  def update
    if @guardian_profile.update_attributes(params[:guardian_profile])
      flash[:success] = "Profile updated"
      redirect_to guardian_profile_path
    else
      @errors = @guardian_profile.errors.full_messages
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User account deleted."
    redirect_to root_url
  end

  def show
  end

end
