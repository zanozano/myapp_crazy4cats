class CreateLikesPosts < ActiveRecord::Migration[7.0]
  def change
    create_table :likes_posts do |t|
      t.integer :like_id
      t.integer :post_id

      t.timestamps
    end
  end
end
