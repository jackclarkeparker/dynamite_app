class PhoneNumberFormatter
  class << self
    def format(input_number)
      replace_plus_64_with_0!(input_number)
      input_number.gsub!(/[^\d]/, '')
      
      prefix, suffix = find_prefix_and_suffix(input_number)
      if suffix.length.between?(6, 9)
        suffix = distribute_suffix_chunks(suffix)

        return prefix + ' ' + suffix if prefix.length > 0 
      end

      prefix + suffix
    end

    private

    def replace_plus_64_with_0!(input_number)
      has_leading_64 = /\A[^\d]*\+64/

      if input_number =~ has_leading_64
        input_number.sub!('+64', '0')
      end
    end

    def find_prefix_and_suffix(input_number)
      if input_number.start_with?('02')
        [ input_number[0, 3], input_number[3..] ]
      elsif input_number =~ /\A0[3-9]/
        [ input_number[0, 2], input_number[2..] ]
      else
        [ '', input_number ]
      end
    end

    def distribute_suffix_chunks(suffix)
      case suffix.length
      when 6
        suffix[0, 3] + ' ' + suffix[3, 3]
      when 7
        suffix[0, 3] + ' ' + suffix[3, 4]
      when 8
        suffix[0, 4] + ' ' + suffix[4, 4]
      when 9
        suffix[0, 3] + ' ' + suffix[3, 3] + ' ' + suffix[6, 3]
      end
    end
  end
end
