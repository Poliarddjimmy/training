require 'faker'

User.create!(
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
  name: "#{Faker::Lorem.word}srerj",
  description: "#{Faker::Lorem.word}"
)

courses = category.courses.create!([
  {
    name: "#{Faker::Lorem.word}",
    description: "#{Faker::Lorem.word}"
  },
  {
    name: "#{Faker::Lorem.word}",
    description: "#{Faker::Lorem.word}"
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