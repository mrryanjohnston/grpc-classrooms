require 'grpc'
require './teacher-profiles_pb.rb'
require './teacher-profiles_services_pb.rb'
require 'active_record'
require '../app/models/application_record.rb'
require '../app/models/teacher.rb'

ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: '../db/development.sqlite3'
)

# GreeterServer is simple server that implements the Helloworld Greeter server.
class TeacherProfilesServer < TeacherProfiles::Service
  # say_hello implements the SayHello rpc method.
  def find(find_req, _unused_call)
    puts "Looking up teacher #{find_req.id}..."
    teacher = Teacher.find(find_req.id)
    puts "Found!"
    ActiveRecord::Base.clear_active_connections!
    TeacherProfile.new(id: teacher.id, name: teacher.name)
  end

  def where(where_req, _unused_call)
    teachery = Teacher.where(name: where_req.name).first
    ActiveRecord::Base.clear_active_connections!
    TeacherProfile.new(id: teacher.id, name: teacher.name)
  end
end

# main starts an RpcServer that receives requests to GreeterServer at the sample
# server port.
def main
  s = GRPC::RpcServer.new
  s.add_http2_port('0.0.0.0:50052', :this_port_is_insecure)
  s.handle(TeacherProfilesServer)
  # Runs the server with SIGHUP, SIGINT and SIGQUIT signal handlers to 
  #   gracefully shutdown.
  # User could also choose to run server via call to run_till_terminated
  s.run_till_terminated_or_interrupted([1, 'int', 'SIGQUIT'])
end

main
