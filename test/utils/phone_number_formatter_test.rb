require "test_helper"
require "phone_number_formatter"

class PhoneNumberFormatterTest < ActiveSupport::TestCase
  PhoneNumberFormatter.format('123456789')

  # HAPPY PATHS
  test "should handle happy paths" do
    assert_equal '021 049 2174', PhoneNumberFormatter.format('021 049 2174')
    assert_equal '021 049 2174', PhoneNumberFormatter.format('021-049-2174')
    assert_equal '021 049 2174', PhoneNumberFormatter.format('0210492174')
  end

  # MOBILE LENGTHS
  test "should handle mobile length 1" do
    assert_equal '027 123 456', PhoneNumberFormatter.format('027123456')
    assert_equal '027 123 4567', PhoneNumberFormatter.format('0271234567')
    assert_equal '027 1234 5678', PhoneNumberFormatter.format('02712345678')
    assert_equal '027 123 456 789', PhoneNumberFormatter.format('027123456789')
    assert_equal '0271234567891', PhoneNumberFormatter.format('0271234567891')
  end

  # LANDLINE LENGTHS

  test "should handle landline lengths" do
    assert_equal '04 973 123', PhoneNumberFormatter.format('04973123')
    assert_equal '04 973 1234', PhoneNumberFormatter.format('049731234')
    assert_equal '04 9731 2345', PhoneNumberFormatter.format('0497312345')
    assert_equal '04 973 123 456', PhoneNumberFormatter.format('04973123456')
    assert_equal '049731234567', PhoneNumberFormatter.format('049731234567')
    assert_equal '973 1234', PhoneNumberFormatter.format('9731234')
    assert_equal '09 731 234', PhoneNumberFormatter.format('09731234')
    assert_equal '210 492 174', PhoneNumberFormatter.format('210492174')
  end

  # OTHER CHARS

  test "should handle other chars" do
    assert_equal '021 049 2174', PhoneNumberFormatter.format('other text0210492174 bla.')
    assert_equal '', PhoneNumberFormatter.format('other text')
    assert_equal '', PhoneNumberFormatter.format('     ')
    assert_equal '3', PhoneNumberFormatter.format(' 3    ')
    assert_equal '021 049 2174', PhoneNumberFormatter.format('0 2 1 0 4 9 2 1 7 4')
    assert_equal '', PhoneNumberFormatter.format('&*()')
    assert_equal '', PhoneNumberFormatter.format('+')
  end

  # +64 inputs
  test "should handle +64 inputs 1" do
    assert_equal '021 363 0565', PhoneNumberFormatter.format('+64 21 363 0565')
    assert_equal '04 973 1234', PhoneNumberFormatter.format('+64 4 973 1234')
  end

  # Interpretted as landline without an area code. Not building for this.
  test "should handle non 64 + inputs" do
    assert_equal '86213630565', PhoneNumberFormatter.format('+86 21 363 0565')
    assert_equal '862 123 456', PhoneNumberFormatter.format('+86 2 123 456')
    assert_equal '8621234567', PhoneNumberFormatter.format('+86 2 123 4567')
  end

  # TO FEW DIGITS
  test "should handle too few digits" do
    assert_equal '3', PhoneNumberFormatter.format('3')
    assert_equal '33', PhoneNumberFormatter.format('33')
    assert_equal '333', PhoneNumberFormatter.format('333')
    assert_equal '3333', PhoneNumberFormatter.format('3333')
    assert_equal '33333', PhoneNumberFormatter.format('33333')
  end

  # LOWEST VALID DIGIT-COUNT
  test "should handle lowest valid digit count" do
    assert_equal '333 333', PhoneNumberFormatter.format('333333')
  end
end

