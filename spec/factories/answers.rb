FactoryBot.define do
  factory :answer do
    text { "MyText" }
    correct { false }
    question { nil }
  end
end
