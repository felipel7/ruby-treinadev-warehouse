class ProductModel < ApplicationRecord
  belongs_to :supplier
  validates :name, :sku, presence: true
end
