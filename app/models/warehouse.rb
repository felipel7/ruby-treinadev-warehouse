class Warehouse < ApplicationRecord
  validates :address, :area, :cep, :city, :code, :description, :name, presence: true
  validates :code, length: { is: 3 }
  validates :code, uniqueness: true

  def full_description
    "#{code} - #{name}"
  end
end
