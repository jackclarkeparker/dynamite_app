class Tutor < ApplicationRecord
  include PhoneNumberFormatting
  include RelatedModelValidator
  include EntityHelper

  belongs_to :region, optional: true
  has_many :lessons

  default_scope { where(valid_until: FUTURE_EPOCH) }

  validates :first_name, :last_name, :email_address,
            :phone_number, :delivery_address, presence: true
  validate :validate_region_id

  validates :phone_number, format: {
    with: /\s/,
    message: 'suffix must be between six and nine digits long'
  }, allow_blank: true
  validates_with UniqueTutorPhoneAndEmailValidator

  before_create :set_full_name, :set_entity_id

  def ==(other_tutor)
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

    def set_full_name
      self.full_name = "#{self.first_name} #{self.last_name}"
    end
end
