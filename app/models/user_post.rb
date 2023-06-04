class UserPost < ApplicationRecord
  belongs_to :user
  belongs_to :post
  belongs_to :like
  belongs_to :post
end
