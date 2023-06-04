class Like < ApplicationRecord
    has_many :likes_posts
    has_many :posts, through: :likes_posts
end
