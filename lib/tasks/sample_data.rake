namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    # create users
    User.create!(name: "ndvan",
                 email: "van@gmail.com",
                 password: "123456",
                 password_confirmation: "123456")
    3.times do |n|
      name  = Faker::Name.name + " " + "#{n+1}"
      email = "#{n+1}@mail.com"
      password  = "123456"
      User.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password)
    end

    # create exam papers
    3.times do |n|
      ep = User.first.exam_papers.build(course_id: n+1, lecturer_id: n+1, exam_date: "10-4-2013", content: "asfd")
      ep.save!
    end
  end
end