require 'grpc'
require './student-profiles_pb'
require './student-profiles_services_pb'
require 'active_record'
require '../app/models/application_record.rb'
require '../app/models/student.rb'

ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: '../db/development.sqlite3'
)

# GreeterServer is simple server that implements the Helloworld Greeter server.
class StudentProfilesServer < StudentProfiles::Service
  # say_hello implements the SayHello rpc method.
  def find(find_req, _unused_call)
    puts "Looking up student #{find_req.id}..."
    student = Student.find(find_req.id)
    puts "Found!"
    ActiveRecord::Base.clear_active_connections!
    StudentProfile.new(id: student.id, name: student.name)
  end

  def where(where_req, _unused_call)
    student = Student.where(name: where_req.name).first
    ActiveRecord::Base.clear_active_connections!
    StudentProfile.new(id: student.id, name: student.name)
  end
end

# main starts an RpcServer that receives requests to GreeterServer at the sample
# server port.
def main
  s = GRPC::RpcServer.new
  s.add_http2_port('0.0.0.0:50051', :this_port_is_insecure)
  s.handle(StudentProfilesServer)
  # Runs the server with SIGHUP, SIGINT and SIGQUIT signal handlers to 
  #   gracefully shutdown.
  # User could also choose to run server via call to run_till_terminated
  s.run_till_terminated_or_interrupted([1, 'int', 'SIGQUIT'])
end

main
