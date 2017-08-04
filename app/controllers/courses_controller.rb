class CoursesController < ApplicationController
  def index
    if params.key?(:name)
      name = params[:name]
      @courses = SwingBySwingService.search_courses(name)
    else
      @courses = []
    end
  end

  def show
    @course = SwingBySwingService.get_course_by_id(params[:id])
  end
end
