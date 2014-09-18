FactoryGirl.define do
  factory :user do |u|
    u.sequence(:email) do |x|
      "jack#{x}@example.com"
    end
    u.password 'password123'
  end
end