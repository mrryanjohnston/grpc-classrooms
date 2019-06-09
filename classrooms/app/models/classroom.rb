require_relative '../../client.rb'
class Classroom < ApplicationRecord
  has_many :classroom_students

  def teacher
    Client.teacher(teacher_id)
  end
end
