# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
classroom1 = Classroom.create(name: "401", teacher_id: 1)
classroom2 = Classroom.create(name: "404", teacher_id: 2)
classroom3 = Classroom.create(name: "500", teacher_id: 3)
classroom4 = Classroom.create(name: "200", teacher_id: 4)

ClassroomStudent.create(classroom: classroom1, student_id: 1)
ClassroomStudent.create(classroom: classroom1, student_id: 3)

ClassroomStudent.create(classroom: classroom2, student_id: 2)
ClassroomStudent.create(classroom: classroom2, student_id: 3)

ClassroomStudent.create(classroom: classroom3, student_id: 3)
ClassroomStudent.create(classroom: classroom3, student_id: 4)

ClassroomStudent.create(classroom: classroom4, student_id: 4)
ClassroomStudent.create(classroom: classroom4, student_id: 2)
ClassroomStudent.create(classroom: classroom4, student_id: 1)
