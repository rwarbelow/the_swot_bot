class Teachers::AssignmentCategoriesController < Teachers::BaseController
	def new
		@course = Course.find(params[:course_id])
	end

  def update_all
		errors = []
		@course = Course.find(params[:course_id])
    @categories = params[:categories]
    @weights = params[:weights]
    @names = params[:names]
    cat_weight_name = @categories.zip(@weights, @names)
    cat_weight_name.each do |cwn|
    	category = AssignmentCategory.find(cwn[0])
    	category.weight = cwn[1]
      category.name = cwn[2]
    	errors << "#{AssignmentCategory.find(cw[0]).name}: #{category.errors.full_messages.first}" unless category.save
    end
    @totalweight = 0
    @course.assignment_categories.each do |ac|
    	@totalweight += ac.weight * 100
    end
    if @totalweight == 100
	    if errors.length > 0
	      flash[:submission_errors] = errors
	      render 'teachers/assignment_categories/index'
	    else
	      flash[:success] = "Categories updated"
	      redirect_to teachers_course_assignment_categories_path(@course)
	    end
	  else
      @totalweight
	  	flash[:error] = "Category weights must add up to 1.00"
	  	render 'teachers/assignment_categories/index'
	  end
  end

	def index
		@course = Course.find(params[:course_id])
		@categories = AssignmentCategory.where(course_id: params[:course_id])
	end

end

