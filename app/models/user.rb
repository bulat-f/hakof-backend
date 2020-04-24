# frozen_string_literal: true

class User < ApplicationRecord
  has_many :articles, foreign_key: :author_id
  has_many :comments, foreign_key: :author_id

  enum role: %i[regular moderator admin]

  has_secure_password
  validates :email, presence: true, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :password,
            length: { minimum: 6 },
            if: -> { new_record? || !password.nil? }

  def token
    return @token if @token

    @token_expiration = 30.days.from_now
    @token = JsonWebToken.encode({ user_id: id }, @token_expiration)
  end

  def token_expiration
    @token_expiration&.strftime('%d-%m-%Y %H:%M')
  end
end
