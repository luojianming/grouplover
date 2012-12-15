namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_users
    make_relationships
  end
end

def make_users
  admin = User.create!(name:  "luojm",
                       email: "xiaoluo@126.com",
                       password: "890527",
                       password_confirmation: "890527")
  99.times do |n|
    name = Faker::Name.name
    email = "xiaoluo#{n+1}@126.com"
    password = "890527"
    User.create!(name: name,
                 email: email,
                 password: password,
                 password_confirmation: password)
  end
end
def make_relationships
  users = User.all
  user = users.first
  followed_users = users[2..50]
  followers = users[3..40]
  followed_users.each { |followed| user.follow!(followed) }
  followers.each  { |follower| follower.follow!(user) }
end

