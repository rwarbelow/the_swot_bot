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

subjects = ["Reading", "Math", "US History", "Science", "Geography", "Writing"]
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

StudentActionCategory.create!(name: "attendance", allow_multiple_entries_per_date: false)
StudentActionCategory.create!(name: "behavior", allow_multiple_entries_per_date: true)
StudentActionCategory.create!(name: "academics", allow_multiple_entries_per_date: false)
StudentActionCategory.create!(name: "missing-assignments", allow_multiple_entries_per_date: true)

#attendance view
  #attendance actions
  StudentActionType.create!(student_action_category_id: 1,name: "on-time", value: 1)
  StudentActionType.create!(student_action_category_id: 1,name: "tardy", value: -1)
  StudentActionType.create!(student_action_category_id: 1,name: "absent", value: -2)

#daily mastery view
  StudentActionType.create!(student_action_category_id: 3,name: "mastered-daily-goal", value: 1)
  StudentActionType.create!(student_action_category_id: 3,name: "incomplete-classwork", value: 0)
  StudentActionType.create!(student_action_category_id: 3,name: "did-not-master-daily-goal", value: 0)

#live class view
  #top 3 positive actions
  StudentActionType.create!(student_action_category_id: 2,name: "high-quality", value: 1)
  StudentActionType.create!(student_action_category_id: 2,name: "participation", value: 1)
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
  StudentActionType.create!(student_action_category_id: 4,name: "missing-assignment", value: -1)

#inspirations
  Inspiration.create!(body: "You must be the change you wish to see in the world.", source: "Gandhi")
  Inspiration.create!(body: "There isn't a person anywhere who isn't capable of doing more than he thinks he can.", source: "Henry Ford")
  Inspiration.create!(body: "Successful people are always looking for opportunities to help others. Unsuccessful people are always asking, what's in it for me?", source: "Brian Tracy")
  Inspiration.create!(body: "Do not go where the path may lead, go instead where there is no path and leave a trail.", source: "Ralph Waldo Emerson")
  Inspiration.create!(body: "There are no shortcuts to any place worth going.", source: "Helen Keller")
  Inspiration.create!(body: "Limitations live only in our minds. But if we use our imaginations, our possibilities become limitless.", source: "Jamie Paolinetti")
  Inspiration.create!(body: "You must begin to think of yourself as becoming the person you want to be.", source: "David Viscott")
  Inspiration.create!(body: "All our dreams can come true if we have the courage to pursue them.", source: "Walt Disney")
  Inspiration.create!(body: "I have learned to use the word impossible with the greatest caution.", source: "Werner Braun")
  Inspiration.create!(body: "Whether you think you can, or think you can't, you're probably right.", source: "Henry Ford")
  Inspiration.create!(body: "When you want to succeed as bad as you want to breathe, then you'll be successful.", source: "Eric Thomas")
  Inspiration.create!(body: "As long as you're going to be thinking anyway, think big.", source: "Donald Trump")
  Inspiration.create!(body: "The only place where success comes before work is in the dictionary.", source: "Vidal Sassoon")
  Inspiration.create!(body: "Success is a state of mind. If you want success, start thinking of yourself as a success.", source: "Dr. Joyce Brothers")
  Inspiration.create!(body: "So many people can be responsible for your success, but only you are responsible for your failure.", source: "Unknown")
  Inspiration.create!(body: "Remember that guy that gave up? Neither does anyone else.", source: "Unknown")
  Inspiration.create!(body: "The way to get started is to quit talking and begin doing.", source: "Walt Disney")
  Inspiration.create!(body: "Never make excuses. Your friends don't need them and your foes won't believe them.", source: "John Wooden")
  Inspiration.create!(body: "Twenty years from now you will be more disappointed by the things that you didn't do than by the ones you did do. Explore. Dream. Discover.", source: "Mark Twain")
  Inspiration.create!(body: "If you want to achieve excellence, you can get there today. As of this second, quit doing less than excellent work.", source: "Thomas J. Watson")
  Inspiration.create!(body: "We are what we repeatedly do. Excellence, therefore, is not an act but a habit.", source: "Aristotle")
