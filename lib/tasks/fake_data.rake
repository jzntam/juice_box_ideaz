namespace :fake_data do

  desc "Database populator"
  task populate: :environment do
    6.times {User.create(first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: Faker::Internet.user_name + "@email.com", password_digest: BCrypt::Password.create("12345678"), password_confirmation: BCrypt::Password.create("12345678"))}

    12.times { |x| Idea.create(title: "Idea #{x + 1} " + Faker::Company.catch_phrase, description: Faker::Hacker.say_something_smart, rank: rand(1...10), user_id: ((User.all.map).each { |x| x.id}).sample )}

    50.times {Comment.create(body: Faker::Lorem.paragraph, user_id: ((User.all.map).each { |x| x.id}).sample, idea_id: ((Idea.all.map).each { |x| x.id}).sample)}

     5.times {Team.create(title: Faker::Name.title, user_id: ((User.all.map).each { |x| x.id}).sample)}

  end

end
