# frozen_string_literal: true

class CommentBlueprint < Blueprinter::Base
  identifier :id
  fields :text

  association :author, blueprint: UserBlueprint
  association :replies, blueprint: CommentBlueprint
end
