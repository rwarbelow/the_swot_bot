module SmsBroadcaster
  def self.broadcast(students, text_body)
    guardians = Guardian.includes(:phone_numbers, :students).where(students: {id: students.map(&:id)}, phone_numbers: {kind: 'cell'})
    guardian_numbers = guardians.map {|guardian| guardian.phone_numbers.map(&:number)}.flatten
    
    TextMessage.sendMessage(to: guardian_numbers,
                            message: text_body)
  end
end
