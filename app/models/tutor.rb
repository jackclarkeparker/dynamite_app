class Tutor < ApplicationRecord
  has_many :lessons

  validates :preferred_name, :first_name, :last_name,
            :email_address, :phone_number, :delivery_address,
            presence: true
  validates :email_address, :phone_number, :full_name, uniqueness: true

  before_create :set_full_name_and_valid_until

  private

    def set_full_name_and_valid_until
      self.full_name = "#{self.first_name} #{self.last_name}"
      self.valid_until = ApplicationRecord::FUTURE_EPOCH
    end
end
