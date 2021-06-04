FactoryBot.define do
  factory :reading do
    time { 1.day.ago }
    value { 1 }
    metric
  end
end
