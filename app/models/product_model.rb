class ProductModel < ApplicationRecord
  belongs_to :supplier
  validates :name, :weight, :width, :height, :depth, :sku, presence: true
  validates :sku, uniqueness: true, length: { maximum: 20 }
  validate :check_dimension_values

  private

  def check_dimension_values
    self.errors.add(:width, " deve ser maior que zero.") if self.width.to_i <= 0
    self.errors.add(:height, " deve ser maior que zero.") if self.height.to_i <= 0
    self.errors.add(:depth, " deve ser maior que zero.") if self.depth.to_i <= 0
    self.errors.add(:weight, " deve ser maior que zero.") if self.weight.to_i <= 0
  end
end
