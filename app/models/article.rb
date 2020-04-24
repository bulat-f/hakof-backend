class Article < ApplicationRecord
  belongs_to :author, class_name: 'User'

  has_many :comments, -> { where(reply_to_id: nil) }
  has_many :all_comment, class_name: 'Comment'
end
