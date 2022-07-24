
class Category < ApplicationRecord

  validates :name, length: {minimum: 3, maximum: 25},presence: true, uniqueness: true

end