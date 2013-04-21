# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :group_groupship do
    applied_group_id 1
    target_group_id 1
    time "MyString"
    location "MyString"
    description "MyString"
  end
end
