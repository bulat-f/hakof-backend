require 'dotenv/load'

namespace :articles do
  desc 'init articles'
  task init: :environment do
    admin = User.first
    data = JSON.parse(File.read('articles.json')).map do |item|
      item.merge author_id: admin.id
    end

    Article.create data

    puts "Now we have #{Article.count} articles"
  end

  desc 'mark articles as featured and selected'
  task mark: :environment do
    # clear old marks
    Article.where(featured: true).update_all(featured: false)
    Article.where(selected: true).update_all(featured: false)

    # create new marks for lang ru
    Article.where(lang: 'ru')
           .order(views_count: :desc)
           .first
           .update(featured: true)
    Article.where(lang: 'ru')
           .order(views_count: :desc)
           .offset(1)
           .limit(3)
           .update_all(selected: true)
    # create new marks for lang tt
    Article.where(lang: 'tt')
           .order(views_count: :desc)
           .first
           .update(featured: true)
    Article.where(lang: 'tt')
           .order(views_count: :desc)
           .offset(1)
           .limit(3)
           .update_all(selected: true)
  end
end