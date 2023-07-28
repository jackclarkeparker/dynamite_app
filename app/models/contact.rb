class Contact < ApplicationRecord
  include RelatedModelValidator

  belongs_to :region, optional: true

  # has_many :student_contacts

  validates :first_name, :email_address, presence: true
  validate :validate_region_id
end
