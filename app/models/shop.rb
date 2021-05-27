class Shop < ApplicationRecord
  has_many :products
  has_many :reviews, through: :products
end
