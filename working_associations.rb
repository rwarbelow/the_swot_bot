# this returns ALL (even duplicates) student_action_type_ids 
array = []
Guardian.find(PhoneNumber.find_by_number("812-322-7607").phone_numberable_id).students.select {|student| student.ccsd_id == "3333334"}.first.student_actions.select {|action| action.date == Date.today}.each do |action|
  array << action.student_action_type_id
end


# this creates a hash with key-value pairs for student_action_type_id numbers 
# and the number of times they appeared in the array
hash = Hash.new(0)
array.each do |n|
  hash[n] +=1
end


# this returns things like "incomplete-classwork: 2"
hash.each do |key, value|
  p "#{StudentActionType.find(key).name}: #{value}"
end
