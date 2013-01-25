# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :message do
    content "MyString"
    conversation_id 1
    sender_id 1
  end
end
