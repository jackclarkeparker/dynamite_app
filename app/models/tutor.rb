class Tutor < ApplicationRecord
  has_many :lessons

  validates :preferred_name, :first_name, :last_name,
            :email_address, :phone_number, :delivery_address,
            presence: true
  validates :email_address, :phone_number, :full_name, uniqueness: true

  before_create :set_full_name_and_valid_until

  def same_attributes_as(other_tutor)
    self.preferred_name == other_tutor.preferred_name &&
    self.first_name == other_tutor.first_name &&
    self.last_name == other_tutor.last_name &&
    self.email_address == other_tutor.email_address &&
    self.phone_number == other_tutor.phone_number &&
    self.delivery_address == other_tutor.delivery_address
  end

  private

    def set_full_name_and_valid_until
      self.full_name = "#{self.first_name} #{self.last_name}"
      self.valid_until = ApplicationRecord::FUTURE_EPOCH
    end
end
