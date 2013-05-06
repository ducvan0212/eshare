namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    # create users
    admin = User.create!(name: "ndvan",
                 email: "van@gmail.com",
                 password: "123456",
                 password_confirmation: "123456")
    admin.avatar = File.open(Rails.root.join('app','assets','images','default_avatar.jpg'))
    admin.toggle!(:admin)
    
    10.times do |n|
      name  = Faker::Name.name + " " + "#{n+1}"
      email = "#{n+1}@mail.com"
      password  = "123456"
      u = User.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password)
      u.avatar = File.open(Rails.root.join('app','assets','images','default_avatar.jpg'))
      u.save!
    end

    # create exam papers
    User.all.each do |user|
      d = Random.new.rand(30)
      m = Random.new.rand(13)
      y = Random.new.rand(2000..2014)
      date = "#{d}-#{m}-#{y}"
      print date
      3.times do |n|
        if !date.nil?
          3.times do |m|
            ep = user.exam_papers.build(lecturer_id: n+1, 
                                      course_id: n+1, 
                                      exam_date: date,
                                      content: Faker::Lorem.paragraphs(paragraph_count = 10))
            ep.save!
          end
        end
      end
    end

    3.times do |n|
      ep = User.first.exam_papers.build(lecturer_id: n+1, 
                                        course_id: n+2, 
                                        exam_date: "10-4-2013", 
                                        content: Faker::Lorem.paragraphs(paragraph_count = 10))
      ep.save!
    end

    # create good
    User.all.take(5).each do |u|
      (u.id + 3).times do |n|
        u.appreciates.create!(exam_paper_id: n+1)
      end
    end

    # create bad
    User.all.take(3).each do |u|
      (u.id + 3).times do |n|
        u.reports.create!(exam_paper_id: n+3)
      end
    end

    # create comments
    User.all.take(5).each do |u|
      10.times do |n|
        u.comments.create!(exam_paper_id: n+1, 
                           content: Faker::Lorem.sentence(word_count = 8))
      end
    end
  end
end