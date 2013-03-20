# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :photo_comment do
    sender_id 1
    receiver_id 1
    content "MyString"
    photo_id 1
    status "MyString"
  end
end
