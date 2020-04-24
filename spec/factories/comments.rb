FactoryBot.define do
  factory :comment do
    author { nil }
    article { nil }
    reply_to { nil }
    text { "MyText" }
  end
end
