FactoryBot.define do
  factory :post do
    sequence(:description) { |n| "test_description#{n}" }
    user
  end
end