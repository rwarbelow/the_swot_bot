gender = ["male", "female"]
ccsd_no = 2222222

1.times do 

  200.times do 
    first_name = Faker::Name.first_name
    last_name = Faker::Name.last_name
    student = StudentProfile.create!(
      :gender => gender.sample,
      :birthday => "1985-05-05",
      :ccsd_id => ccsd_no += 1,
      :grade_level => 7,
      :email => Faker::Internet.email)

    student.build_user_identity(
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
    guardian = GuardianProfile.create!(preferred_language: "English")

    guardian.build_user_identity(
      :password => 'password',
      :first_name => first_name,
      :last_name => last_name,
      :guardian_profile_id => guardian.id,
      :username => "#{first_name}#{last_name}")
    guardian.save
    p "Guardian Created: #{guardian.username}" 
  end

  200.times do |i|
    guardianship = Guardianship.create!(
      :student_profile_id => i + 1,
      :guardian_profile_id => i + 1,
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
  teacher = TeacherProfile.create!(
    :title => Faker::Lorem.words(num = 1),
    :email => Faker::Internet.email)

  teacher.build_user_identity(
    :password => 'password',
    :first_name => first_name,
    :last_name => last_name,
    :username => "#{first_name}#{last_name}",
    :teacher_profile_id => teacher.id)
  teacher.save
    p "Teacher Created: #{teacher.username}" 


  7.times do |i|
    Course.create!(
      teacher_profile_id: teacher.id,
      period: i + 1,
      subject_id: (1..70).to_a.sample
    )
    p "Course Created period"
  end
end

