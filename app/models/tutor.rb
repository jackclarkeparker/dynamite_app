class Tutor < ApplicationRecord
  has_many :lessons

  validates :preferred_name, :first_name, :last_name,
            :email_address, :phone_number, :delivery_address,
            presence: true
  validates :email_address, :phone_number, :full_name, uniqueness: true
end
