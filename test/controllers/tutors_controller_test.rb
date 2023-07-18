require "test_helper"

class TutorsControllerTest < ActionDispatch::IntegrationTest
  QUOTE_HTML_ENTITY = '&#39;'

  setup do
    @tutor = tutors(:jack)
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
      post tutors_url, params: {
        tutor: {
          email_address: 'gary@email.com',
          first_name: 'Gary',
          last_name: 'Mason',
          delivery_address: '39 Majoribanks St',
          phone_number: '022 676 3747',
          preferred_name: 'Gee'
        }
      }
    end

    assert_redirected_to tutor_url(Tutor.last)
    follow_redirect!

    assert_select 'p', "Tutor was successfully created."
    assert_select 'main div p', /First name:.*Gary/m
  end

  test "should create tutor without preferred name" do
    assert_difference("Tutor.count", 1) do
      post tutors_url, params: {
        tutor: {
          email_address: 'gary@email.com',
          first_name: 'Sam',
          last_name: 'Mason',
          delivery_address: '39 Majoribanks St',
          phone_number: '022 676 3747',
          preferred_name: ''
        }
      }
    end

    assert_redirected_to tutor_url(Tutor.last)
    follow_redirect!

    assert_select 'p', "Tutor was successfully created."
  end

  test "should fail to create tutor" do
    assert_difference("Tutor.count", 0) do
      post tutors_url, params: {
        tutor: {
          email_address: 'jack@dynamite_music.co.nz',
          first_name: 'Jack',
          last_name: 'Guy',
          delivery_address: '145 Marion St',
          phone_number: '0210492174',
        }
      }
    end

    assert_response 422

    assert_match '<h1>New tutor</h1>', response.body

    assert_match '<h2>2 errors prohibited this tutor from being saved:</h2>', response.body
    assert_match '<li>Email address in use by another tutor</li>', response.body
    assert_match '<li>Phone number in use by another tutor</li>', response.body
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
        email_address: "new@email.com",
        first_name: @tutor.first_name,
        last_name: @tutor.last_name,
        delivery_address: @tutor.delivery_address,
        phone_number: @tutor.phone_number,
        preferred_name: @tutor.preferred_name
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
        email_address: @tutor.email_address,
        first_name: '',
        last_name: @tutor.last_name,
        delivery_address: @tutor.delivery_address,
        phone_number: @tutor.phone_number,
        preferred_name: @tutor.preferred_name
      }
    }

    assert_response 422

    assert_match '<h1>Editing tutor</h1>', response.body

    assert_match '<h2>1 error prohibited this tutor from being saved:</h2>', response.body
    assert_match "<li>First name can#{QUOTE_HTML_ENTITY}t be blank</li>", response.body
  end

  # test "should destroy tutor" do
  #   assert_difference("Tutor.count", -1) do
  #     delete tutor_url(@tutor)
  #   end

  #   assert_redirected_to tutors_url
  # end
end
