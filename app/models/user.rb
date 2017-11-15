class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :scorecards

  has_many :active_connections, class_name: "UserConnection",
                                foreign_key: "follower_id",
                                dependent: :destroy

  has_many :passive_connections, class_name: "UserConnection",
                                 foreign_key: "followed_id",
                                 dependent: :destroy

  has_many :following, through: :active_connections, source: :followed
  has_many :followers, through: :passive_connections

  def hole_scores
    result = []
    self.scorecards.each do |scorecard|
      scorecard.hole_scores.each do |holescore|
        result.push(holescore)
      end
    end

    result
  end

  def fairway_avg
    sum = 0
    self.hole_scores.each do |holescore|
      if holescore.fairway == true
        sum += 1
      end
    end

    (1.0 * sum / self.hole_scores.length * 100).round(2)
  end

  def gir_avg
    sum = 0
    self.hole_scores.each do |holescore|
      if holescore.green_ir == true
        sum += 1
      end
    end

    (1.0 * sum / self.hole_scores.length * 100).round(2)
  end

  def avg_score_per_game
    total = 0.0
    self.scorecards.each do |scorecard|
      total += ((18.0 / scorecard.holes.length) * scorecard.total_score)
    end
    (total / self.scorecards.length).round(2)
  end

  def avg_num_of_putts
    total = 0.0
    self.scorecards.each do |scorecard|
      total += ((18.0 / scorecard.holes.length ) * scorecard.num_of_putts)
    end
    (total / self.scorecards.length).round(2)
  end


end
