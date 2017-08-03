class CoursesController < ApplicationController
  def index
    if params.key?(:name)
      name = params[:name]
      SwingBySwingService.search_courses(name)
    end

    @courses = []
  end
end
