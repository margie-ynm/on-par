class ScorecardsController < ApplicationController
  def create
    course_id = params[:course_id]
    @scorecard = Scorecard.new
    @scorecard.course_id = course_id
    @scorecard.delete_holes
    if @scorecard.save
      holes = SwingBySwingService.get_holes_for_course(course_id)
      holes.each do |hole|
        hole.save
      end
      redirect_to "/courses/#{course_id}"
    end
  end
end
