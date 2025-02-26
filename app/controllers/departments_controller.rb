class DepartmentsController < ApplicationController
  def index
    @list_of_departments = Department.all.order({ :created_at => :desc })

    render({ :template => "departments/index" })
  end

  def show
    the_id = params.fetch("path_id")
    @the_department = Department.where({ :id => the_id }).at(0)

    render({ :template => "departments/show" })
  end

  def create
    d = Department.new
    d.name = params.fetch("query_name")

    if d.valid?
      d.save
      redirect_to("/departments", { :notice => "Department created successfully." })
    else
      redirect_to("/departments", { :notice => "Department failed to create successfully." })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_department = Department.where({ :id => the_id }).at(0)

    the_department.name = params.fetch("query_name")

    if the_department.valid?
      the_department.save
      redirect_to("/departments/#{the_department.id}", { :notice => "Department updated successfully."} )
    else
      redirect_to("/departments/#{the_department.id}", { :alert => "Department failed to update successfully." })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_department = Department.where({ :id => the_id }).at(0)

    the_department.destroy

    redirect_to("/departments", { :notice => "Department deleted successfully."} )
  end
end
