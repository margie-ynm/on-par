class ScorecardsController < ApplicationController

  def show
    @scorecard = Scorecard.find(params[:id])
  end

  def new
    self.create
  end

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
      redirect_to new_course_scorecard_hole_score_path(course_id, @scorecard.id)
    end
  end

end
