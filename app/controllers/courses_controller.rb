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
    course_id = params[:id]
    @course = SwingBySwingService.get_course_by_id(course_id)
    
    @holes = SwingBySwingService.get_holes_for_course(course_id)
    @holes.each do |hole|
      hole.save
    end

  end
end
