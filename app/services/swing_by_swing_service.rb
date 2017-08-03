class SwingBySwingService
  def self.search_courses(name)
    url="https://api.swingbyswing.com/v2/courses/search_by_term?name=#{name}&active_only=yes&order_by=name&limit=20&access_token=#{ENV['access_token']}"
    response = RestClient.get(url).body
    rawCourseData = JSON.parse(response, symbolize_names: true)

    courses = rawCourseData[:courses].map do |datum|
      Course.new(datum[:id], datum[:name])
    end

    courses
  end
end
