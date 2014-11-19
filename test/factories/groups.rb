# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :group do
    sequence(:name) { |n| ("religious_#{n}") }
    icon 'awesome-religious'
  end
end
