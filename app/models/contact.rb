class Contact < ApplicationRecord
  include RelatedModelValidator
  include PhoneNumberFormatting

  belongs_to :region, optional: true

  has_many :student_contacts

  validates :first_name, :email_address, presence: true
  validate :validate_region_id

  before_create :set_full_name_and_valid_until

  def ==(other_contact)
    region_id      == other_contact.region_id &&
    first_name     == other_contact.first_name &&
    last_name      == other_contact.last_name &&
    preferred_name == other_contact.preferred_name &&
    email_address  == other_contact.email_address &&
    phone_number   == other_contact.phone_number &&
    bank_account   == other_contact.bank_account &&
    csc_number     == other_contact.csc_number
  end

  private

    def set_full_name_and_valid_until
      self.full_name = first_name
      self.full_name += " #{last_name}" if last_name && last_name.length > 0 
      self.valid_until = ApplicationRecord::FUTURE_EPOCH
    end
end
