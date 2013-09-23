class Admin::StudentProfilesController < Admin::BaseController
  def show
    @student = Student.find(params[:id])
  end

  def edit
    @student = Student.find(params[:id])
    @identity = @student.identity
    render 'admin/student_profiles/edit'
  end

  def update
    @student = Student.find(params[:id])
    @identity = @student.identity
    @identity.update_attributes(:first_name => params[:identity][:first_name], 
                                  :last_name => params[:identity][:last_name],
                                  :username => params[:identity][:username],
                                  :password => params[:identity][:password],
                                  :password_confirmation => params[:identity][:password_confirmation])
    @student.update_attributes(:birthday => params[:student][:birthday], 
                                  :gender => params[:student][:gender],
                                  :grade_level => params[:student][:grade_level],
                                  :ccsd_id => params[:student][:ccsd_id],
                                  :email => params[:student][:email])
    if @identity.save && @student.save
      flash[:success] = "Profile updated"
      redirect_to admin_student_profiles_path
    else
      @errors = @identity.errors.full_messages
      render 'edit'
    end
  end

  def new
    @student = Student.new
  end

  def create
    address = "#{params[:student][:address_line_1]} #{params[:student][:address_line_2]} #{params[:student][:address_city]} #{params[:student][:address_state]} #{params[:student][:address_zip_code]}"
    @student = Student.new(params[:student])
    @student.address = address
    @identity = @student.build_identity(params[:identity])
    begin
      Student.transaction do
        @student.save!
        @identity.student_id = @student.id
        @identity.save!
        @student.reload
        @identity.reload
      end
      redirect_to admin_student_profiles_path
      rescue ActiveRecord::RecordInvalid => invalid
        flash[:errors] = @student.errors.full_messages + @identity.errors.full_messages
        render 'new'
    end
  end

  def index
    @students = Student.all.sort! {|x, y| x.last_name <=> y.last_name}
  end

  def import
    Student.import(params[:file])
    redirect_to admin_root_url
  end

  def csv_importer
  end
end
