class Comment < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :article
  belongs_to :reply_to, class_name: 'Comment', optional: true

  has_many :replies, class_name: 'Comment', foreign_key: :reply_to_id
end
