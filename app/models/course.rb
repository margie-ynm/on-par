DB = PG.connect({dbname: "on_par_#{Rails.env}" })

class Course
  attr_accessor(:name, :id, :hole_count, :image_path, :city, :state)

  def initialize(id = nil, name='', hole_count = 0, image_path = '', city = '', state = '')
    @id = id
    @name = name
    @hole_count = hole_count
    @image_path = image_path
    @city = city
    @state = state
  end

  def scorecards
    DB.exec("SELECT * FROM scorecards WHERE course_id = #{self.id};").map do |scorecard|
      Scorecard.new({id: scorecard.fetch('id'), course_id: scorecard.fetch('course_id'), playdate: scorecard.fetch('playdate')})
    end

  end
end
