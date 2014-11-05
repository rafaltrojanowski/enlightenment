# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :content_entity do
    content 'MyText'
    user
    group
  end
end
