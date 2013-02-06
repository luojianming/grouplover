# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :private_message do
    sender_id 1
    receiver_id 1
    content "MyString"
  end
end
