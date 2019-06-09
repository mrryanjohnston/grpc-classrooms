require_relative '../../client.rb'
class ClassroomStudent < ApplicationRecord
  belongs_to :classroom

  def student
    Client.student(student_id)
  end
end
