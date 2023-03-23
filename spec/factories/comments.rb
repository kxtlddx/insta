FactoryBot.define do
  factory :comment do
    sequence(:text) { |n| "test_text#{n}" }
    user
    post
  end
end