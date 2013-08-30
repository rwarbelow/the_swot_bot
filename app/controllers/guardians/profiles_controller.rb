class Guardians::ProfilesController < Guardians::BaseController
  skip_before_filter :require_guardian, :only => [:new, :create]

  def edit
    @guardian = Guardian.find(params[:id])
    @user = current_user
    @phone_numbers = @guardian.phone_numbers
    if @guardian && @guardian.id == current_user.guardian.id
      render 'edit'
    else
      redirect_to error_url
    end
  end

  def update
    @guardian = Guardian.find(params[:id])
    @guardian.update_attributes(params[:guardian])
    if @guardian.save
      flash[:success] = "Profile updated"
      redirect_to guardians_root_path
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
    @guardian = Guardian.find(params[:profile_id])
    if Student.exists?(:ccsd_id => ccsd_id, :registration_code => registration_code)
      @student = Student.where(:registration_code => registration_code, :ccsd_id => ccsd_id).first
      @guardianship = Guardianship.new(:student_id => student.id,
                          :guardian_id => @guardian.id,
                          :relationship_to_student => params[:guardianship][:relationship_to_student])
      if @guardianship.save
        flash[:success] = "#{@student.first_name} added"
        redirect_to guardians_root_path(@guardian)
      else
        @errors = @guardianship.errors.full_messages
        flash[:guardianship_errors] = @errors
        render 'guardians/dashboard/index'
      end
    else
      @guardianship = Guardianship.new
      flash[:registration_errors] = "The registration code and CCSD ID you entered do not match."
      render 'guardians/dashboard/index'
    end
  end

  def add_phone_number
    @phone_number = PhoneNumber.new(params[:phone_number])
    @phone_number.phone_numberable_id = current_guardian.id
    @phone_number.phone_numberable_type = "Guardian"
    @phone_number.save
    flash[:success] = "#{@phone_number.number} added"
    redirect_to guardians_root_path
  end

  def delete_phone_number
    @phone_number = PhoneNumber.find(params[:phone_number_id])
    number = @phone_number.number
    @phone_number.destroy
    flash[:success] = "#{number} deleted"
    redirect_to edit_guardians_profile_path(current_guardian)
  end
end
