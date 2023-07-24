require "test_helper"

class TutorsControllerTest < ActionDispatch::IntegrationTest
  QUOTE_UNICODE = '&#39;'

  setup do
    @tutor = tutors(:andy)
  end

  test "should get index" do
    get tutors_url
    assert_response :success
  end

  test "should get new" do
    get new_tutor_url
    assert_response :success
  end

  test "should create tutor" do
    assert_difference("Tutor.count", 1) do
      post tutors_url, params: default_tutor_params
    end

    assert_redirected_to tutor_url(Tutor.last)
    follow_redirect!

    assert_select 'p', "Tutor was successfully created."
    assert_select 'main div p', /First name:.*Gary/m
  end

  test "should create tutor without preferred name" do
    params = default_tutor_params
    params[:tutor][:preferred_name] = ''

    assert_difference("Tutor.count", 1) do
      post tutors_url, params: params
    end

    assert_redirected_to tutor_url(Tutor.last)
    follow_redirect!

    assert_select 'p', "Tutor was successfully created."
  end

  test "should fail to create tutor with missing params" do
    assert_difference("Tutor.count", 0) do
      post tutors_url, params: {
        tutor: {
          first_name: '',
          last_name: '',
          email_address: '',
          phone_number: '',  
          region_id: '',
          delivery_address: '',
        }
      }
    end

    assert_response 422

    assert_match '<h1>New tutor</h1>', response.body
    assert_match '<h2>6 errors prohibited this tutor from being saved:</h2>', response.body
    assert_match "<li>First name can#{QUOTE_UNICODE}t be blank</li>", response.body
    assert_match "<li>Last name can#{QUOTE_UNICODE}t be blank</li>", response.body
    assert_match "<li>Email address can#{QUOTE_UNICODE}t be blank</li>", response.body
    assert_match "<li>Phone number can#{QUOTE_UNICODE}t be blank</li>", response.body
    assert_match "<li>Delivery address can#{QUOTE_UNICODE}t be blank</li>", response.body
    assert_match "<li>Region must be selected</li>", response.body
  end

  test "should fail to create tutor with duplicate email / phone" do
    params = default_tutor_params
    params[:tutor][:email_address] = 'andrew@dynamite_music.co.nz'
    params[:tutor][:phone_number] = '021 123 4567'

    assert_difference("Tutor.count", 0) do
      post tutors_url, params: params
    end

    assert_response 422

    assert_match '<h1>New tutor</h1>', response.body

    assert_match '<h2>2 errors prohibited this tutor from being saved:</h2>', response.body
    assert_match '<li>Email address in use by another tutor</li>', response.body
    assert_match '<li>Phone number in use by another tutor</li>', response.body
  end

  test "should complain about too-many-digits phone number" do
    params = default_tutor_params
    params[:tutor][:phone_number] = '027 1234567890'

    assert_difference("Tutor.count", 0) do
      post tutors_url, params: params
    end

    assert_response 422

    assert_match '<h1>New tutor</h1>', response.body
    assert_match '<h2>1 error prohibited this tutor from being saved:</h2>', response.body
    assert_match "<li>Phone number suffix must be between six and nine digits long</li>", response.body
  end

  test "should complain about too-few-digits phone number" do
    params = default_tutor_params
    params[:tutor][:phone_number] = '027 12345'

    assert_difference("Tutor.count", 0) do
      post tutors_url, params: params
    end

    assert_response 422

    assert_match '<h1>New tutor</h1>', response.body
    assert_match '<h2>1 error prohibited this tutor from being saved:</h2>', response.body
    assert_match "<li>Phone number suffix must be between six and nine digits long</li>", response.body
  end

  test "Should fail to make tutor with invalid region selection" do
    params = default_tutor_params
    params[:tutor][:region_id] = 123456789

    post tutors_url, params: params

    assert_response 422

    assert_match '<h1>New tutor</h1>', response.body
    assert_match '<h2>1 error prohibited this tutor from being saved:</h2>', response.body
    assert_match "<li>Region must be selected</li>", response.body
  end

  test "should show tutor" do
    get tutor_url(@tutor)
    assert_response :success
  end

  test "should get edit" do
    get edit_tutor_url(@tutor)
    assert_response :success
  end

  test "should update tutor" do
    patch tutor_url(@tutor), params: {
      tutor: {
        first_name: @tutor.first_name,
        last_name: @tutor.last_name,
        preferred_name: @tutor.preferred_name,
        email_address: "new@email.com",
        phone_number: @tutor.phone_number,
        region_id: @tutor.region_id,
        delivery_address: @tutor.delivery_address,
      }
    }

    refute response['Location'] =~ /\/tutors\/#{@tutor.id}\z/
    assert response['Location'] =~ /\/tutors\/\d+\z/

    follow_redirect!

    assert_select 'p', "Tutor was successfully updated."
    assert_select 'main div p', /Email address:.*new@email.com/m
  end

  test "should alert of update without changes" do
    patch tutor_url(@tutor), params: {
      tutor: {
        email_address: @tutor.email_address,
        first_name: @tutor.first_name,
        last_name: @tutor.last_name,
        delivery_address: @tutor.delivery_address,
        phone_number: @tutor.phone_number,
        preferred_name: @tutor.preferred_name
      }
    }

    assert_redirected_to tutor_url(@tutor)
    follow_redirect!

    assert_select 'p', "No changes made to tutor."
  end

  test "should fail to update tutor" do
    patch tutor_url(@tutor), params: {
      tutor: {
        first_name: '',
        last_name: @tutor.last_name,
        preferred_name: @tutor.preferred_name,
        email_address: @tutor.email_address,
        phone_number: @tutor.phone_number,
        region_id: @tutor.region_id,
        delivery_address: @tutor.delivery_address,
      }
    }

    assert_response 422

    assert_match '<h1>Editing tutor</h1>', response.body

    assert_match '<h2>1 error prohibited this tutor from being saved:</h2>', response.body
    assert_match "<li>First name can#{QUOTE_UNICODE}t be blank</li>", response.body
  end

  # test "should destroy tutor" do
  #   assert_difference("Tutor.count", -1) do
  #     delete tutor_url(@tutor)
  #   end

  #   assert_redirected_to tutors_url
  # end
end
