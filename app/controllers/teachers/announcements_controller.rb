 class Teachers::AnnouncementsController < Teachers::BaseController

  def new
  end

  def create
    @announcement = Announcement.new(params[:announcement])
    @announcement.teacher_id = current_teacher.id
    if @announcement.save
      redirect_to teachers_profile_path(current_teacher)
    else
      @errors = @announcement.errors.full_messages
      flash[:errors] = @errors
      render 'teachers/profiles/show'
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def show
  end

  def index
  end


end
