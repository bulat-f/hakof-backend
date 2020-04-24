# frozen_string_literal: true

class ArticleBlueprint < Blueprinter::Base
  identifier :id

  view :normal do
    fields :title, :cover, :description, :slug, :published_at,
           :featured, :selected
  end

  view :extended do
    include_view :normal
    fields :body
    association :author, blueprint: UserBlueprint
    association :comments, blueprint: CommentBlueprint
  end

  view :with_stats do
    include_view :extended
    fields :views_count, :views_till_end_count, :comments_count
  end
end
