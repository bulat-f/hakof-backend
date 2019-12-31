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
end