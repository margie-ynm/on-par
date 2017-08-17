class CoursesController < ApplicationController
  def index
    if params.key?(:search_name)
      name = params[:search_name]
      @courses = SwingBySwingService.search_courses(name)
    else
      @courses = []
    end
  end

  def show
    course_id = params[:id]
    @course = SwingBySwingService.get_course_by_id(course_id)
  end
end
