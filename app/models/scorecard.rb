DB = PG.connect({dbname: 'on_par_development'})

class Scorecard < ActiveRecord::Base
  has_many :hole_scores

  def holes
    DB.exec("SELECT * FROM holes WHERE course_id = #{self.course_id};").map do |hole|
      Hole.new({hole_num: hole.fetch('hole_num'), course_id: hole.fetch('course_id'), par: hole.fetch('par'), yards: hole.fetch('yards'), id: hole.fetch('id')})
    end
  end

  def delete_holes
    DB.exec("DELETE FROM holes WHERE course_id = #{self.course_id};")
  end

  def completed?
    self.hole_scores.length == self.holes.length
  end

end
