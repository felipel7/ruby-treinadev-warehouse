class Supplier < ApplicationRecord
  validates :corporate_name, :brand_name, :registration_number, :full_address, :city, :state, :email, presence: true
  validates :registration_number, uniqueness: true, length: { is: 13 }

  before_validation :clean_up_registration_number
  after_validation :formatted_registration_number

  private

  def clean_up_registration_number
    self.registration_number = self.registration_number&.gsub(/\D/, "")
  end

  def formatted_registration_number
    self.registration_number = self.registration_number&.gsub(/(\d{2})(\d{3})(\d{3})(\d{4})(\d{1})/, '\1.\2.\3/\4-\5')
  end
end
