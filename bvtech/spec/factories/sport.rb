FactoryBot.define do
  factory :sport do
    sequence :name do |n|
      "Sport ##{n}"
    end

    sequence(:external_id, (1..100000).to_a.shuffle.to_enum)

    trait :inactive do
      active { false }
    end
  end
end
