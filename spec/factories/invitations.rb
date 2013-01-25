# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :invitation do
    initiate_group_id 1
    time "MyString"
    location "MyString"
    description "MyString"
    status ""
    lover_style "MyString"
  end
end
