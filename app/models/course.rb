class Course
  attr_reader(:name, :id, :hole_count, :image_path, :city, :state)

  def initialize(id, name='', hole_count = 0, image_path = '', city = '', state = '')
    @id = id
    @name = name
    @hole_count = hole_count
    @image_path = image_path
    @city = city
    @state = state
  end
end
