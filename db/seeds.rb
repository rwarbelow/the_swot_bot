# gender = ["male", "female"]
# ccsd_no = 3333333

# 1.times do 

#   200.times do 
#     first_name = Faker::Name.first_name
#     last_name = Faker::Name.last_name
#     student = Student.create!(
#       :gender => gender.sample,
#       :birthday => "1985-05-05",
#       :ccsd_id => ccsd_no += 1,
#       :grade_level => 7,
#       :email => Faker::Internet.email)

#     student.build_identity(
#       :password => 'password',
#       :first_name => first_name,
#       :last_name => last_name,
#       :username => "#{first_name}#{last_name}")
#     student.save
#     p "Student Created: #{student.username}  #{student.ccsd_id}" 
#   end

#   200.times do 
#     first_name = Faker::Name.first_name
#     last_name = Faker::Name.last_name
#     guardian = Guardian.create!(preferred_language: "English")

#     guardian.build_identity(
#       :password => 'password',
#       :first_name => first_name,
#       :last_name => last_name,
#       :guardian_id => guardian.id,
#       :username => "#{first_name}#{last_name}")
#     guardian.save
#     p "Guardian Created: #{guardian.username}" 
#   end

#   200.times do |i|
#     guardianship = Guardianship.create!(
#       :student_id => i + 1,
#       :guardian_id => i + 1,
#       :relationship_to_student => 'Parent')
#     p "guardianship created"
#   end
# end

# subjects = ["English", "Math", "History", "Science", "Juggling", "Sex ed"]
# subjects.each do |subject| 
#   7.times do |i|
#     Subject.create!(:name => "#{subject} 10#{i}")
#     p "created Subject #{subject} 10#{i}"
#   end
# end

# 10.times do 
#   first_name = Faker::Name.first_name
#   last_name = Faker::Name.last_name
#   teacher = Teacher.create!(
#     :title => Faker::Lorem.words(num = 1),
#     :email => Faker::Internet.email)

#   teacher.build_identity(
#     :password => 'password',
#     :first_name => first_name,
#     :last_name => last_name,
#     :username => "#{first_name}#{last_name}",
#     :teacher_id => teacher.id)
#   teacher.save
#   p "Teacher Created: #{teacher.username}" 

#   7.times do |i|
#     Course.create!(
#       teacher_id: teacher.id,
#       period: i + 1,
#       subject_id: (1..70).to_a.sample
#       )
#     p "Course Created period"
#   end
# end

# students = Student.all

# 6.times do
#   students.each do |student|
#     enrollment = Enrollment.new(
#       :student_id => student.id,
#       :course_id => Course.all.sample.id)
#       until enrollment.valid?
#         enrollment.course = Course.all.sample
#       end
#       enrollment.save
#     p "Enrollment created for #{student.first_name}"
#   end
# end

StudentActionCategory.create!(name: "Attendance")
StudentActionCategory.create!(name: "Behavior")
StudentActionCategory.create!(name: "Academics")
StudentActionType.create!(student_action_category_id: 1,name: "On-Time", value: 1)
StudentActionType.create!(student_action_category_id: 1,name: "Tardy", value: -1)
StudentActionType.create!(student_action_category_id: 1,name: "Absent", value: -2)
StudentActionType.create!(student_action_category_id: 2,name: "Helping Others", value: 1)
StudentActionType.create!(student_action_category_id: 2,name: "Integrity", value: 1)
StudentActionType.create!(student_action_category_id: 2,name: "Leadership", value: 1)
StudentActionType.create!(student_action_category_id: 2,name: "Perserverance", value: 1)
StudentActionType.create!(student_action_category_id: 2,name: "Problem-Solving", value: 1)
StudentActionType.create!(student_action_category_id: 2,name: "Resisting Distractions", value: 1)
StudentActionType.create!(student_action_category_id: 2,name: "Respect to Others", value: 1)
StudentActionType.create!(student_action_category_id: 2,name: "Team Work", value: 1)
StudentActionType.create!(student_action_category_id: 2,name: "Working Independently", value: 1)
StudentActionType.create!(student_action_category_id: 2,name: "Baby-Attack", value: -1)
StudentActionType.create!(student_action_category_id: 2,name: "Calling Out", value: -1)
StudentActionType.create!(student_action_category_id: 2,name: "Disrespecting Others", value: -1)
StudentActionType.create!(student_action_category_id: 2,name: "Distracting Others", value: -1)
StudentActionType.create!(student_action_category_id: 2,name: "Ignoring Instructions", value: -1)
StudentActionType.create!(student_action_category_id: 2,name: "Laughing at Others Mistakes", value: -1)
StudentActionType.create!(student_action_category_id: 2,name: "Not Completing Classwork", value: -1)
StudentActionType.create!(student_action_category_id: 2,name: "Not Participating", value: -1)
StudentActionType.create!(student_action_category_id: 2,name: "Side Conversation", value: -1)
StudentActionType.create!(student_action_category_id: 2,name: "Sloppy SLANT", value: -1)
StudentActionType.create!(student_action_category_id: 3,name: "Mastered Daily Goal", value: 1)
StudentActionType.create!(student_action_category_id: 3,name: "Did Not Master Daily Goal", value: -1)
StudentActionType.create!(student_action_category_id: 3,name: "Participation", value: 1)























