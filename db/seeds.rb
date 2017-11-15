
exampleCourseId = 11267

exampleUser = User.new(email: "user@example.com", password: "password")
exampleUser.save

exampleUser2 = User.new(email: "user2@example.com", password: "password2")
exampleUser2.save

exampleUser3 = User.new(email: "user3@example.com", password: "password3")
exampleUser3.save

exampleUser4 = User.new(email: "user4@example.com", password: "password4")
exampleUser4.save

exampleScorecard = exampleUser.scorecards.create(course_id: exampleCourseId, playdate: Time.new)

hole_scores_list = [
  [1, 5, 3, false, true],
  [2, 6, 4, true, true],
  [3, 3, 1, true, true],
  [4, 7, 5, true, true],
  [5, 7, 2, true, true],
  [6, 4, 2, false, true],
  [7, 7, 2, true, true],
  [8, 7, 3, true, false],
  [9, 6, 3, true, true],
  [10, 5, 2, false, true],
  [11, 4, 2, true, false],
  [12, 8, 4, false, true],
  [13, 4, 2, false, true],
  [14, 3, 1, true, false],
  [15, 6, 3, false, true],
  [16, 5, 2, false, false],
  [17, 4, 2, true, false],
  [18, 6, 2, true, true]
]

hole_scores_list.each do |el|
  exampleScorecard.hole_scores.create(
    hole_num: el[0],
    score: el[1],
    number_of_putts: el[2],
    fairway: el[3],
    green_ir: el[4]
  )
end
