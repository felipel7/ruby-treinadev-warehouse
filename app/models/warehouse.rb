class Warehouse < ApplicationRecord
  validates :address, :area, :cep, :city, :code, :description, :name, presence: true
  validates :code, length: { is: 3 }
  validates :name, :code, uniqueness: true
  validates :cep, format: { with: /\A\d{5}-\d{3}\z/, message: " deve ser neste formato: 00000-000" }

  def full_description
    "#{code} - #{name}"
  end
end
