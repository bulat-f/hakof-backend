# frozen_string_literal: true

class UserBlueprint < Blueprinter::Base
  identifier :id
  fields :first_name, :last_name

  view :normal do
    fields :email, :role
  end

  view :extended do
    include_view :normal
    fields :created_at, :updated_at
  end

  view :auth do
    include_view :extended
    fields :token, :token_expiration
  end
end
