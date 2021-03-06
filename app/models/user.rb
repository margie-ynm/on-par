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
  has_many :followers, through: :passive_connections, source: :follower

  scope :search_email, -> (name_parameter) { where(email: name_parameter.downcase) }

  def follow(other_user)
    following << other_user
  end

  def unfollow(other_user)
    following.delete(other_user)
  end

  def following?(other_user)
    following.include?(other_user)
  end

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
    count = 0
    self.scorecards.each do |scorecard|
      if scorecard.completed?
        scorecard.hole_scores.each do |holescore|
          if holescore.fairway == true
            sum += 1
          end
          count += 1
        end
      end
    end

    (1.0 * sum / count * 100).round(2)
  end

  def gir_avg
    sum = 0
    count = 0
    self.scorecards.each do |scorecard|
      if scorecard.completed?
        scorecard.hole_scores.each do |holescore|
          if holescore.green_ir == true
            sum += 1
          end
          count +=1
        end
      end
    end

    (1.0 * sum / count * 100).round(2)
  end

  def avg_score_per_game
    total = 0.0
    count = 0
    self.scorecards.each do |scorecard|
      if scorecard.completed?
        total += ((18.0 / scorecard.holes.length) * scorecard.total_score)
        count += 1
      end
    end
    (total / count).round(2)
  end

  def avg_num_of_putts
    total = 0.0
    count = 0
    self.scorecards.each do |scorecard|
      if scorecard.completed?
        total += ((18.0 / scorecard.holes.length ) * scorecard.num_of_putts)
        count += 1
      end
    end
    (total / count).round(2)
  end


end
