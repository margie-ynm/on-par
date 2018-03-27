class Scorecard < ActiveRecord::Base
  has_many :hole_scores
  belongs_to :user

  def course_name
    course = SwingBySwingService.get_course_by_id(self.course_id)

    "#{course.name}"
  end

  def date_format
    self.playdate.strftime("%m/%d/%Y")
  end

  def holes
    holes = Hole.where(course_id: self.course_id)

    if !holes.any?
      holes = SwingBySwingService.get_holes_for_course(course_id)
      holes.each do |hole|
        hole.save
      end
    end

    holes
  end

  def find_hole_by_hole_num(number)
    holes = self.holes
    index = holes.find_index do |hole|
      hole.hole_num == number
    end
    holes[index]
  end

  def completed?
    self.hole_scores.length == self.holes.length
  end

  def number_of_holes
    self.hole_scores.count
  end

  def fairway_count
    num = 0
    self.hole_scores.each do |holescore|
      if holescore.fairway == true
        num += 1
      end
    end
    num
  end

  def gir_count
    sum = 0
    self.hole_scores.each do |holescore|
      if holescore.green_ir == true
        sum +=1
      end
    end
    sum
  end

  def total_score
    score = 0
    self.hole_scores.each do |holescore|
      score = score + holescore.score
    end
    score
  end

  def num_of_putts
    putts = 0
    self.hole_scores.each do |holescore|
      putts = putts + holescore.number_of_putts
    end
    putts
  end

end
