class Category < ActiveRecord::Base
  has_many :post_categories
  has_many :posts, through: :post_categories, foreign_key: :post_id

  validates :name, presence: true
end