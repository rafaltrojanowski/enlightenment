FactoryGirl.define do
  factory :user do |u|
    u.sequence(:email) { |x| "jack#{x}@example.com" }
    u.password 'password123'
  end
end
