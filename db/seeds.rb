student = StudentProfile.create!(
  gender: "male",
  birthday: "1985-05-05",
  ccsd_id: "1234567",
  grade_level: 7
)

UserIdentity.create!(
  username: 'teststudent',
  password: 'password',
  first_name: 'Stu',
  last_name: 'Dent',
  student_profile_id: student.id,
)

guardian_profile = GuardianProfile.create!(
  preferred_language: "English",
)

guardianship = Guardianship.create!(
  student_profile_id: student.id,
  guardian_profile_id: guardian_profile.id,
  relationship_to_student: 'Parent'
)

user_identity = UserIdentity.create!(
  username: 'testguardian',
  password: 'password',
  first_name: 'Test',
  last_name: 'Guardian',
  guardian_profile_id: guardian_profile.id
)
