class Tutor < ApplicationRecord
  include PhoneNumberFormatting

  belongs_to :region, optional: true
  has_many :lessons

  validates :first_name, :last_name, :email_address,
            :phone_number, :delivery_address,
            :entity_id, presence: true
  validates :region_id, presence: { message: "must be selected" }
  validate :validate_region_id
  validates :phone_number, format: {
    with: /\s/,
    message: 'suffix must be between six and nine digits long'
  }, allow_blank: true
  validates_with UniqueTutorPhoneAndEmailValidator

  after_initialize :format_phone_number
  before_create :set_full_name_and_valid_until

  def same_attributes_as(other_tutor)
    self.preferred_name == other_tutor.preferred_name &&
    self.first_name == other_tutor.first_name &&
    self.last_name == other_tutor.last_name &&
    self.email_address == other_tutor.email_address &&
    self.phone_number == other_tutor.phone_number &&
    self.delivery_address == other_tutor.delivery_address
  end

  def to_s
    if self.preferred_name && self.preferred_name.length > 0
      self.preferred_name
    else
      self.first_name
    end
  end

  private

    def set_full_name_and_valid_until
      self.full_name = "#{self.first_name} #{self.last_name}"
      self.valid_until = ApplicationRecord::FUTURE_EPOCH
    end

    def validate_region_id
      if region_id && !Region.exists?(id: region_id)
        errors.add(:region, 'must be selected')
      end
    end
end
