require "test_helper"

class TutorsControllerTest < ActionDispatch::IntegrationTest
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
    assert_select 'main div p', /First name:.{5}Gary/m
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

    assert_select 'h1', 'New tutor'
    assert_select 'h2', '6 errors prohibited this tutor from being saved:'
    assert_select 'li', "First name can't be blank"
    assert_select 'li', "Last name can't be blank"
    assert_select 'li', "Email address can't be blank"
    assert_select 'li', "Phone number can't be blank"
    assert_select 'li', "Delivery address can't be blank"
    assert_select 'li', 'Region must be selected'
  end

  test "should fail to create tutor with duplicate email / phone" do
    params = default_tutor_params
    params[:tutor][:email_address] = 'andrew@dynamite_music.co.nz'
    params[:tutor][:phone_number] = '021 123 4567'

    assert_difference("Tutor.count", 0) do
      post tutors_url, params: params
    end

    assert_response 422

    assert_select 'h1', 'New tutor'

    assert_select 'h2', '2 errors prohibited this tutor from being saved:'
    assert_select 'li', 'Email address in use by another tutor'
    assert_select 'li', 'Phone number in use by another tutor'
  end

  test "should complain about too-many-digits phone number" do
    params = default_tutor_params
    params[:tutor][:phone_number] = '027 1234567890'

    assert_difference("Tutor.count", 0) do
      post tutors_url, params: params
    end

    assert_response 422

    assert_select 'h1', 'New tutor'
    assert_select 'h2', '1 error prohibited this tutor from being saved:'
    assert_select 'li', 'Phone number suffix must be between six and nine digits long'
  end

  test "should complain about too-few-digits phone number" do
    params = default_tutor_params
    params[:tutor][:phone_number] = '027 12345'

    assert_difference("Tutor.count", 0) do
      post tutors_url, params: params
    end

    assert_response 422

    assert_select 'h1', 'New tutor'
    assert_select 'h2', '1 error prohibited this tutor from being saved:'
    assert_select 'li', 'Phone number suffix must be between six and nine digits long'
  end

  test "Should fail to make tutor with invalid region selection" do
    params = default_tutor_params
    params[:tutor][:region_id] = 123456789

    post tutors_url, params: params

    assert_response 422

    assert_select 'h1', 'New tutor'
    assert_select 'h2', '1 error prohibited this tutor from being saved:'
    assert_select 'li', 'Region must be selected'
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
    assert_select 'main div p', /Email address:.{5}new@email.com/m
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

  test "should fail to update tutor when missing params" do
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

    assert_select 'h1', 'Editing tutor'

    assert_select 'h2', '1 error prohibited this tutor from being saved:'
    assert_select 'li', "First name can't be blank"

    # This works. I'll use the simpler approach in other tests
    first_name_is_empty = false
    css_select('form div').each do |div|
      target_label = css_select(div, 'label').text == 'First name'
      input_value_empty = css_select(div, 'input').attribute('value')&.text == ''

      if target_label && input_value_empty
        first_name_is_empty = true
        break
      end
    end

    assert first_name_is_empty
  end

  test "should fail to destroy tutor with associations" do
    assert_difference("Tutor.count", 0) do
      delete tutor_url(@tutor)
    end

    assert_redirected_to tutor_url(@tutor)
    follow_redirect!

    assert_select 'p', "Rejected destruction of tutor 'Andy' because it: - has associated lessons."
  end

  test "should destroy tutor" do
    assert_difference(active_tutor_count, 1) do
      post tutors_url, params: default_tutor_params
    end

    assert_difference(active_tutor_count, -1) do
      delete tutor_url(Tutor.last)
    end

    assert_redirected_to tutors_url
    follow_redirect!

    assert_select 'p', 'Tutor was successfully destroyed.'
  end
end
