require 'faker'

Category.create([{title: 'HTML'}, {title: 'CSS'},
                 {title: 'JavaScript'}, {title: 'jQuery'}, {title: 'Ruby'}])

admin = User.find_by(email: 'yulatax@gmail.com')

if admin.nil?
  admin = Admin.create(
      first_name: 'Admin',
      last_name: 'Admin',
      email: 'admin@test-guru.com',
      password: '123456',
      password_confirmation: '123456'
  )
end

p admin

Test.create([
    {title: 'HTML Test1', category_id: 1, author_id: admin.id},
    {title: 'CSS Test1', category_id: 2, author_id: admin.id},
    {title: 'CSS Test2', category_id: 2, level: 1, author_id: admin.id},
    {title: 'CSS Test3', category_id: 2, level: 1, author_id: admin.id},
    {title: 'jQuery Test1', category_id: 4, author_id: admin.id},
    {title: 'jQuery Test2', category_id: 4, level: 1, author_id: admin.id},
    {title: 'HTML Test2', category_id: 1, level: 1, author_id: admin.id},
    {title: 'Javascript Test3', category_id: 3, level: 3, author_id: admin.id},
    {title: 'Javascript Test2', category_id: 3, level: 2, author_id: admin.id}])

30.times do
  id = Faker::Number.between(from: Test.first[:id], to: Test.last[:id])
  Question.create(body: Faker::Lorem.question, test_id: id)
end

questions = Question.all
questions.each do |question|
  answers_number = Faker::Number.between(from: 3, to: 4)
  answers_number.times do
    Answer.create(body: Faker::Lorem.sentence, correct: Faker::Boolean.boolean(true_ratio: 0.5), question_id: question.id)
  end
end

p "Created #{Category.count} categories"
# p "Created #{User.count} users"
p "Created #{Test.count} tests"
p "Created #{Question.count} questions"
p "Created #{Answer.count} answers"