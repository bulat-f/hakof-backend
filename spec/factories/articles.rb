FactoryBot.define do
  factory :article do
    title { "MyString" }
    cover { "MyString" }
    description { "MyString" }
    slug { "MyString" }
    selected { false }
    featured { false }
    body { "MyText" }
    user { nil }
  end
end
