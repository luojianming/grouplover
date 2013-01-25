#encoding: utf-8
namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_users
    make_relationships
    make_groups
  end

  task invitation_populate: :environment do
    make_invitations
  end

  task profile_populate: :environment do
    make_profile
  end

  task conversation_populate: :environment do
    make_conversations
  end
end

def make_users
  admin = User.create!(name:  "luojm",
                       email: "xiaoluo@126.com",
                       password: "890527",
                       password_confirmation: "890527")
  99.times do |n|
    name = "luojm#{n+1}"
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

def make_groups
  users = User.all
  10.times do |n|
    name = "Group#{n+1}"
    description = "等待就是浪费青春"
    location = "北京"
    team_leader_id = n+1
    status = "active"
    labels = "帅气 阳光"
	sex = true
    
    g = users[n+2].mygroups.create(name: name,
					  sex: sex,
					  description: description,
					  location: location,
					  team_leader_id: team_leader_id,
					  status: status,
					  labels: labels)
    g.group_memberships.create(member_id: n+2,
                               status: "accepted")
    g.group_memberships.create(member_id: n+3,
                               status: "accepted")
    g.group_memberships.create(member_id: n+4,
                               status: "accepted")

  end
end

def make_invitations
  groups = Group.all
  60.times do |n|
    invitation = Invitation.create!(initiate_group_id: n%10+1,
                                    time: "2012-12-26",
                                    location: "清华园",
                                    description: "等待就是浪费青春",
                                    status: "pending",
                                    lover_style: "可爱 善良",
                                    style: "帅气 才华",
                                    activity: "三国杀",
                                    image_url: "photo/#{n%10+1}.jpg")
  end

end

def make_profile

  User.all.each do |user|
    avatar = "pic2.jpg"
    lover_style = "可爱 性格好"
    hobby = "篮球 乒乓求 k歌"
    hometown = "湖南"
    location = "北京"
    style = "帅气 聪明"
    sex = true
    status = "active"
    user.create_profile(:birthday => 1989,
                        avatar: avatar,
                        lover_style: lover_style,
                        hobby: hobby,
                        hometown: hometown,
                        location: location,
                        style: style,
                        sex: sex,
                        status: status)
  end
end

def make_conversations
  @groups = Group.all
  @groups.each do |group|
    group.create_conversation()
  end
end
