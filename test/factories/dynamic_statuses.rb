# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :dynamic_status do
    user_id 1
    content "MyString"
    sender_id 1
    receiver_id 1
    original_status_id 1
  end
end
