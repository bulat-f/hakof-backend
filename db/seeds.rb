# frozen_string_literal: true

data = JSON.parse(File.read('result.json')).reverse

user = User.create first_name: 'Rashit', last_name: 'F',
                   email: 'hakof@mail.ru',
                   password: 'Password1', password_confirmation: 'Password1',
                   role: 'admin'

data_with_user = data.map { |item| item.merge author_id: user.id }
Article.create data_with_user
