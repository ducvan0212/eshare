namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
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
  end
end