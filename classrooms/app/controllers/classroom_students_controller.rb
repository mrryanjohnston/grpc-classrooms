class ClassroomStudentsController < ApplicationController
  def index
    @classroom_students = ClassroomStudent.all
  end
end
