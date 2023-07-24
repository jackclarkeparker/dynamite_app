require "test_helper"

class TutorTest < ActiveSupport::TestCase
  test "Should set defaults for full_name and valid_until" do
    jack = Tutor.new({
      first_name: 'Jack',
      last_name: 'Clarke-Parker',
      phone_number: '021 049 2174',
      email_address: 'jack@dynamitemusic.co.nz',
      delivery_address: '137 Clyde Street, Island Bay',
      region_id: regions(:wellington).id
    })
    jack.entity_id = 1
    jack.save

    assert jack.valid?
    assert_equal 'Jack Clarke-Parker', jack.full_name
    assert_equal ApplicationRecord::FUTURE_EPOCH, jack.valid_until
  end

  test "Should use previous versions entity_id" do
    # patch tutor_url(@tutor), params: {
    #   tutor: {
    #     email_address: @tutor.email_address,
    #     first_name: 'Changed name',
    #     last_name: @tutor.last_name,
    #     delivery_address: @tutor.delivery_address,
    #     phone_number: @tutor.phone_number,
    #   }
    # }
  end

  test "region_id must be valid" do
    params = default_tutor_params
    params[:tutor][:region_id] = 123456789

    tutor = Tutor.new(params[:tutor])
    assert tutor.invalid?
    assert tutor.errors[:region].any?
  end


  # In order to follow my own logic, I need to write some tests
  # that validate and record all of my thinking
  # - Initialising with good defaults for; 'full_name', 'valid_until'
  # - That you can't pass an entity_id that is different
  # - That you can't choose which entity_id to update for
end
