class Contact < ApplicationRecord
  include RelatedModelValidator
  include PhoneNumberFormatting

  belongs_to :region, optional: true

  has_many :student_contacts
  has_many :students, through: :student_contacts

  has_one :booking, inverse_of: :contact

  default_scope { where(valid_until: FUTURE_EPOCH)}

  validates :first_name, :email_address, presence: true
  validate :validate_region_id

  before_create :set_full_name

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

  def to_s
    if self.preferred_name && self.preferred_name.length > 0
      self.preferred_name
    else
      self.first_name
    end
  end

  private

    def set_full_name
      self.full_name = first_name
      self.full_name += " #{last_name}" if last_name && last_name.length > 0 
    end
end
