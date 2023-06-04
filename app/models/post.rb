class Post < ApplicationRecord
  has_many :user_posts
  has_many :users, through: :user_posts
  has_many :comments
  has_many :likes_posts
  has_many :post_likes, through: :likes_posts, source: :like
  has_many :likes, dependent: :destroy
end
