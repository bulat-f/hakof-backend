require 'dotenv/load'

namespace :admin do
  desc 'create admin user'
  task create: :environment do
    admin = User.new first_name: ENV['ADMIN_FIRST_NAME'],
                     last_name: ENV['ADMIN_LAST_NAME'],
                     email: ENV['ADMIN_EMAIL'],
                     password: ENV['ADMIN_PASSWORD'],
                     password_confirmation: ENV['ADMIN_PASSWORD'],
                     role: 'admin'

    if admin.save
      puts "Admin (email: #{admin.email}) is created"
    else
      puts 'Something went wrong'
    end
  end
end