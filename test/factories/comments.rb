# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :comment do
    content "MyString"
    commentable_id 1
    commentable_type "MyString"
    sender_id 1
    receiver_id 1
  end
end
