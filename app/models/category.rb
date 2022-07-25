
class Category < ApplicationRecord

  has_many :article_categories
  has_many :articles, through: :article_categories

  validates :name, length: {minimum: 3, maximum: 25},presence: true, uniqueness: true

end