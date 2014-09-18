# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :administrator do
    first_name 'James'
    last_name 'Bond'
    email Configurable[:email]
    password 'q1w2e3r4'
  end
end
