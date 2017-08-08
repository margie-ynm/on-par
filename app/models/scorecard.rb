DB = PG.connect({dbname: 'on_par_development'})

class Scorecard < ActiveRecord::Base

  def holes
    DB.exec("SELECT * FROM holes WHERE course_id = #{self.course_id};").map do |hole|
      Hole.new({hole_num: hole.fetch('hole_num'), course_id: hole.fetch('course_id'), par: hole.fetch('par'), yards: hole.fetch('yards'), id: hole.fetch('id')})
    end
  end
end
