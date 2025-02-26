class StudentsController < ApplicationController
  def index
    @list_of_students = Student.all.order({ :created_at => :desc })

    render({ :template => "students/index" })
  end

  def show
    the_id = params.fetch("path_id")
    @the_student = Student.where({ :id => the_id }).at(0)

    render({ :template => "students/show" })
  end

  def create
    s = Student.new
    s.first_name = params.fetch("query_first_name")
    s.last_name = params.fetch("query_last_name")
    s.email = params.fetch("query_email")

    if s.valid?
      s.save
      redirect_to("/students", { :notice => "Student created successfully." })
    else
      redirect_to("/students", { :notice => "Student failed to create successfully." })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_student = Student.where({ :id => the_id }).at(0)

    the_student.first_name = params.fetch("query_first_name")
    the_student.last_name = params.fetch("query_last_name")
    the_student.email = params.fetch("query_email")

    if the_student.valid?
      the_student.save
      redirect_to("/students/#{the_student.id}", { :notice => "Student updated successfully."} )
    else
      redirect_to("/students/#{the_student.id}", { :alert => "Student failed to update successfully." })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_student = Student.where({ :id => the_id }).at(0)

    the_student.destroy

    redirect_to("/students", { :notice => "Student deleted successfully."} )
  end
end
