# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :photo do
    name "MyString"
    album_id 1
    description "MyString"
    image "MyString"
  end
end
