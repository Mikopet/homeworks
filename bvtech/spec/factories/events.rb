FactoryBot.define do
  factory :event do
    sequence :name do |n|
      "Event ##{n}"
    end

    due_date { Time.now + 2.days }

    sport
  end
end

