# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :link do
    url "MyString"
    title nil
    description "MyText"
    image "MyString"
    content_entity
  end
end
