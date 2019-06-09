require 'grpc'
require '../student-profiles/lib/student-profiles_services_pb'
require '../teacher-profiles/lib/teacher-profiles_services_pb'

class Client
  def self.student(id)
    student_stub = StudentProfiles::Stub.new('0.0.0.0:50051', :this_channel_is_insecure)
    student_stub.find(StudentProfile.new(id: id))
  end

  def self.teacher(id)
    teacher_stub = TeacherProfiles::Stub.new('0.0.0.0:50052', :this_channel_is_insecure)
    teacher_stub.find(TeacherProfile.new(id: id))
  end
end
