class CoursesController < ApplicationController
  def index
    if params.key?(:name)
      name = params[:name]
      @courses = SwingBySwingService.search_courses(name)
    else
      @courses = []
    end
  end
end
