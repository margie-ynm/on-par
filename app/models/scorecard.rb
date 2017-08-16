DB = PG.connect({dbname: "on_par_#{Rails.env}" })

class Scorecard < ActiveRecord::Base
  has_many :hole_scores
  belongs_to :user

  def description
    course = SwingBySwingService.get_course_by_id(self.course_id)

    "#{course.name} - #{self.date_format}"
  end

  def date_format
    self.playdate.strftime("%m/%d/%Y")
  end

  def holes
    holes = DB.exec("SELECT * FROM holes WHERE course_id = #{self.course_id};").map do |hole|
      Hole.new({hole_num: hole.fetch('hole_num'), course_id: hole.fetch('course_id'), par: hole.fetch('par'), yards: hole.fetch('yards'), id: hole.fetch('id')})
    end

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

  def delete_holes
    DB.exec("DELETE FROM holes WHERE course_id = #{self.course_id};")
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
