CSV.generate do |csv|
	csv << ["#{@teacher.last_name} #{@course.subject.name}"]
	csv << [@assignment_categories]
	csv << []
	Term.all.each do |term|
		csv << ["#{term.name.upcase}"]
		assignments = [""]
		max_points = [""]
		due_dates = [""]
		categories = [""]
		@term_assignments = @assignments.where(term_id: term.id)
		@term_assignments.each do |assignment|
			assignments << "#{assignment.title}"
			max_points << "#{assignment.maximum_points} points"
			due_dates << "#{assignment.due_date}"
			categories << "#{assignment.assignment_category.name}"
		end
		csv << assignments
		csv << max_points
		csv << due_dates
		csv << categories
		@students.each do |s|
			@score_collection = []
			@term_assignments.each do |assignment|
				@submission = Submission.find_by_student_id_and_assignment_id(s.id, assignment.id)
				score = @submission.nil? ? "" : @submission.points_earned
				@score_collection << score
			end
			csv << ["#{s.first_name} #{s.last_name}"] + @score_collection
		end
		csv << []
		csv << []
		csv << []
	end
end
