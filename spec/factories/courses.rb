FactoryBot.define do
  factory :course do
    user { nil }
    session { nil }
    score { 1 }
    comments { "MyText" }
    progress { 1 }
  end
end
