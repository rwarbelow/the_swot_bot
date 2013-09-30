module SmsBroadcaster
  def self.broadcast(students, text_body)
    guardian_numbers = students.map do |student|
      student.guardians.map do |guardian|
        guardian.textable_numbers.map do |phone|
          "+1" + phone.number
        end
      end
    end.flatten

    TextMessage.sendMessage(to: guardian_numbers,
                            message: text_body)
  end
end
