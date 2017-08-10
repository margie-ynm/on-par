class HoleScoresController < ApplicationController
  def new
    @course_id = params[:course_id]
    @scorecard = Scorecard.find(params[:scorecard_id])
    @holescore = @scorecard.hole_scores.new
  end

  def create
    course_id = params[:course_id]
    @scorecard = Scorecard.find(params[:scorecard_id])
    @holescore = @scorecard.hole_scores.new(hole_score_params)
    if @holescore.save
      redirect_to course_scorecard_path(course_id, @scorecard.id)
    else
      render :new
    end
  end

  private
    def hole_score_params
      params.require(:hole_score).permit(:score, :green_ir, :fairway, :number_of_putts)
    end
end
