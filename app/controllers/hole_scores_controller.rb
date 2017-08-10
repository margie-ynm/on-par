class HoleScoresController < ApplicationController
  def new
    @course_id = params[:course_id]
    @scorecard = Scorecard.find(params[:scorecard_id])
    @holescore = @scorecard.hole_scores.new
    hole_scores = @scorecard.hole_scores.order(:hole_num)
    if hole_scores.any?
      hole_num = hole_scores.last.hole_num + 1
    else
      hole_num = 1
    end
    @holescore.hole_num = hole_num
  end

  def create
    course_id = params[:course_id]
    @scorecard = Scorecard.find(params[:scorecard_id])
    hole_scores = @scorecard.hole_scores.order(:hole_num)
    if hole_scores.any?
      hole_num = hole_scores.last.hole_num + 1
    else
      hole_num = 1
    end
    @holescore = @scorecard.hole_scores.new(hole_score_params)
    @holescore.hole_num = hole_num
    if @holescore.save
      if @scorecard.completed?
        @scorecard.delete_holes
        redirect_to course_scorecard_path(course_id, @scorecard.id)
      else
        redirect_to new_course_scorecard_hole_score_path(course_id, @scorecard.id)
      end
    else
      render :new
    end
  end

  private
    def hole_score_params
      params.require(:hole_score).permit(:score, :green_ir, :fairway, :number_of_putts)
    end
end
