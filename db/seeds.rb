gender = ["male", "female"]
ccsd_no = 3333333

1.times do 

  200.times do 
    first_name = Faker::Name.first_name
    last_name = Faker::Name.last_name
    student = Student.create!(
      :gender => gender.sample,
      :birthday => "1985-05-05",
      :ccsd_id => ccsd_no += 1,
      :grade_level => 7,
      :email => Faker::Internet.email)

    student.build_identity(
      :password => 'password',
      :first_name => first_name,
      :last_name => last_name,
      :username => "#{first_name}#{last_name}")
    student.save
    p "Student Created: #{student.username}  #{student.ccsd_id}" 
  end

  200.times do 
    first_name = Faker::Name.first_name
    last_name = Faker::Name.last_name
    guardian = Guardian.create!(preferred_language: "English")

    guardian.build_identity(
      :password => 'password',
      :first_name => first_name,
      :last_name => last_name,
      :guardian_id => guardian.id,
      :username => "#{first_name}#{last_name}")
    guardian.save
    p "Guardian Created: #{guardian.username}" 
  end

  200.times do |i|
    guardianship = Guardianship.create!(
      :student_id => i + 1,
      :guardian_id => i + 1,
      :relationship_to_student => 'Parent')
    p "guardianship created"
  end
end

subjects = ["English", "Math", "History", "Science", "Juggling", "Sex ed"]
subjects.each do |subject| 
  7.times do |i|
    Subject.create!(:name => "#{subject} 10#{i}")
    p "created Subject #{subject} 10#{i}"
  end
end

10.times do 
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  teacher = Teacher.create!(
    :title => Faker::Lorem.words(num = 1),
    :email => Faker::Internet.email)

  teacher.build_identity(
    :password => 'password',
    :first_name => first_name,
    :last_name => last_name,
    :username => "#{first_name}#{last_name}",
    :teacher_id => teacher.id)
  teacher.save
  p "Teacher Created: #{teacher.username}" 

  7.times do |i|
    course = Course.new(
      teacher_id: teacher.id,
      period: i + 1,
      subject_id: Subject.all.sample.id)
      until course.valid?
        course.subject_id = Subject.all.sample
      end
      course.save
    p "Course Created period #{course.period}"
  end
end

6.times do
  students = Student.all
  students.each do |student|
    enrollment = Enrollment.new(
      :student_id => student.id,
      :course_id => Course.all.sample.id)
      until enrollment.valid?
        enrollment.course = Course.all.sample
      end
      enrollment.save
    p "Enrollment created for #{student.first_name}"
  end
end

StudentActionCategory.create!(name: "Attendance")
StudentActionCategory.create!(name: "Behavior")
StudentActionCategory.create!(name: "Academics")

#attendance view
  #attendance actions
  StudentActionType.create!(student_action_category_id: 1,name: "on-time", value: 1)
  StudentActionType.create!(student_action_category_id: 1,name: "tardy", value: -1)
  StudentActionType.create!(student_action_category_id: 1,name: "absent", value: -2)

#daily mastery view
  StudentActionType.create!(student_action_category_id: 3,name: "mastered-daily-goal", value: 1)
  StudentActionType.create!(student_action_category_id: 3,name: "incomplete-classwork", value: -1)
  StudentActionType.create!(student_action_category_id: 3,name: "did-not-master-daily-goal", value: -1)

#live class view
  #top 3 positive actions
  StudentActionType.create!(student_action_category_id: 3,name: "high-quality", value: 1)
  StudentActionType.create!(student_action_category_id: 3,name: "participation", value: 1)
  StudentActionType.create!(student_action_category_id: 2,name: "resisting-distractions", value: 1)
  #top 3 negative actions
  StudentActionType.create!(student_action_category_id: 2,name: "baby-attack", value: -1)
  StudentActionType.create!(student_action_category_id: 2,name: "causing-distractions", value: -1)
  StudentActionType.create!(student_action_category_id: 2,name: "sloppy-work", value: -1)

#other behaviors list view
  #positive behavior actions
  StudentActionType.create!(student_action_category_id: 2,name: "helping-others", value: 1)
  StudentActionType.create!(student_action_category_id: 2,name: "integrity", value: 1)
  StudentActionType.create!(student_action_category_id: 2,name: "leadership", value: 1)
  StudentActionType.create!(student_action_category_id: 2,name: "perseverance", value: 1)
  StudentActionType.create!(student_action_category_id: 2,name: "problem-solving", value: 1)
  StudentActionType.create!(student_action_category_id: 2,name: "respect-to-others", value: 1)
  StudentActionType.create!(student_action_category_id: 2,name: "team-work", value: 1)
  StudentActionType.create!(student_action_category_id: 2,name: "working-independently", value: 1)
  #negative behavior actions
  StudentActionType.create!(student_action_category_id: 2,name: "calling-out", value: -1)
  StudentActionType.create!(student_action_category_id: 2,name: "disrespecting-others", value: -1)
  StudentActionType.create!(student_action_category_id: 2,name: "ignoring-instructions", value: -1)
  StudentActionType.create!(student_action_category_id: 2,name: "laughing-at-others-mistakes", value: -1)
  StudentActionType.create!(student_action_category_id: 3,name: "not-participating", value: -1)
  StudentActionType.create!(student_action_category_id: 2,name: "side-conversations", value: -1)
  StudentActionType.create!(student_action_category_id: 2,name: "sloppy-slant", value: -1)
  StudentActionType.create!(student_action_category_id: 2,name: "swearing", value: -1)
