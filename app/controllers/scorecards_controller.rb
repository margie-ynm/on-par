class ScorecardsController < ApplicationController
  before_action :authenticate_user!

  def show
    @scorecard = Scorecard.find(params[:id])
  end

  def new
    self.create
  end

  def create
    course_id = params[:course_id]
    @scorecard = current_user.scorecards.new(playdate: Time.new, course_id: course_id)
    if @scorecard.save
      @scorecard.holes # using side effects to ensure dbase populated w/ course holes
      redirect_to new_course_scorecard_hole_score_path(course_id, @scorecard.id)
    end
  end

end
