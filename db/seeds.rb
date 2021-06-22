require 'faker'

user = User.create!(
  email: "poliarddjimmy@gmail.com",
  password: "23jim0488",
  name: "Djimmy Poliard",
  username: "jey11"
)

User.create!(
  email: "acheraime@gmail.com",
  password: "23jim0488",
  name: "Adolph Cheraime",
  username: "acher"
)

category = Category.create!(
  name: "Web development",
  description: "All course on web development"
)

courses = category.courses.create!([
  {
    name: "full stack development",
    description: "The study plan is developed over 12 months. The Master's Degree is made up of 10 modules and a Final Master's Project, with a clear business link, which begins at the end of the first module and extends throughout the entire program. ",
    user: user,
    picture: "https://media.geeksforgeeks.org/wp-content/cdn-uploads/20190626123927/untitlsssssed.png"
  },
  {
    name: "Learn HTML/CSS",
    description: "You can launch a new career in web development today by learning HTML & CSS. You don't need a computer science degree or expensive software. All you need is a computer, a bit of time, a lot of determination, and a teacher you trust. I've taught HTML and CSS to countless coworkers and held training sessions for fortune 100 companies. I am that teacher you can trust.",
    user: user,
    picture: "https://cdn-media-1.freecodecamp.org/ghost/2019/04/css-html-1.png"
  }
])

chapters = courses.each do |course|
  course.chapters.create!(
    title: "#{Faker::Lorem.word}",
    description: "#{Faker::Lorem.word}",
    objective: "#{Faker::Lorem.word}",
  )
end

Course.first.chapters.create!(
    title: "This is a lesson",
    description: "This is a description for this lesson",
    objective: "This is a objective for this lesson"
  )

Chapter.all.each do |chapter|
  chapter.lessons.create!(
    title: "#{Faker::Lorem.word}",
    description: "#{Faker::Lorem.word}",
    content: "#{Faker::Lorem.word}"
  )
end

Chapter.first.lessons.create!(
    title: "This is a lesson",
    description: "This is a description for this lesson",
    content: "This is a content for this lesson"
  )