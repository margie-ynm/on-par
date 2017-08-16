class ScorecardsController < ApplicationController
  before_action :authenticate_user!

  def show
    @scorecard = Scorecard.find(params[:id])
  end

  def new
    @scorecard = current_user.scorecards.new(course_id: params[:course_id])
  end

  def create
    course_id = params[:course_id]
    @scorecard = current_user.scorecards.new({course_id: course_id}.merge(scorecard_params))
    if @scorecard.save
      @scorecard.holes # using side effects to ensure dbase populated w/ course holes
      redirect_to new_course_scorecard_hole_score_path(course_id, @scorecard.id)
    end
  end

private
  def scorecard_params
    params.require(:scorecard).permit(:playdate)
  end

end
