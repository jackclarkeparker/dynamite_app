module PhoneNumberFormatting
  extend ActiveSupport::Concern

  included do
    before_validation :format_phone_number
  end

  private

    def format_phone_number
      if phone_number
        self.phone_number = PhoneNumberFormatter.format(phone_number)
      end
    end
end
