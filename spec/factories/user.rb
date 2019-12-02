# frozen_string_literal: true

FactoryBot.define do
  factory :user, aliases: [:author] do
    first_name { 'John' }
    last_name  { 'Doe' }
    email { "#{first_name}.#{last_name}@example.com".downcase }
    password { 'password1' }
    password_confirmation { 'password1' }
  end

  factory :admin, parent: :user do
    role { 'admin' }
  end
end
