require "test_helper"

class VenuesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @venue = venues(:miramar)
  end

  test "should get index" do
    get venues_url
    assert_response :success
  end

  test "should get new" do
    get new_venue_url
    assert_response :success
  end

  test "should create venue" do
    assert_difference("Venue.count") do
      post venues_url, params: default_venue_params
    end

    assert_redirected_to venue_url(Venue.last)

    follow_redirect!

    assert_select 'p', "Venue was successfully created."
    assert_select 'main div p', /Name:.{5}EBIS/m
  end

  test "should fail to create venue with missing params" do
    assert_difference("Venue.count", 0) do
      post venues_url, params: {
        venue: {
          region_id: '',
          name: '',
          address: '',
          standard_price: '',
        }
      }
    end

    assert_response 422

    assert_match '<h1>New venue</h1>', response.body
    assert_match '<h2>4 errors prohibited this venue from being saved:</h2>', response.body
    assert_match "<li>Name can#{QUOTE_UNICODE}t be blank</li>", response.body
    assert_match "<li>Address can#{QUOTE_UNICODE}t be blank</li>", response.body
    assert_match "<li>Standard price can#{QUOTE_UNICODE}t be blank</li>", response.body    
    assert_match "<li>Region must be selected</li>", response.body
  end

  test "should fail to create venue with non-unique name / address" do
    params = default_venue_params
    params[:venue][:name] = 'Newtown School'
    params[:venue][:address] = 'Mein Street'

    assert_difference("Venue.count", 0) do
      post venues_url, params: params
    end

    assert_response 422

    assert_match '<h1>New venue</h1>', response.body

    assert_match '<h2>2 errors prohibited this venue from being saved:</h2>', response.body
    assert_match '<li>Name already used by another venue in this region</li>', response.body
    assert_match '<li>Address in use by another venue</li>', response.body
  end

  test "should create venue with duplicate name if in a different region" do
    params = default_venue_params
    params[:venue][:name] = 'Newtown School'
    params[:venue][:region_id] = regions(:new_plymouth).id

    assert_difference("Venue.count", 1) do
      post venues_url, params: params
    end

    assert_redirected_to venue_url(Venue.last)

    follow_redirect!

    assert_select 'p', "Venue was successfully created."
  end

  test "Should fail to make venue with invalid region selection" do
    params = default_venue_params
    params[:venue][:region_id] = 123456789

    post venues_url, params: params

    assert_response 422

    assert_match '<h1>New venue</h1>', response.body
    assert_match '<h2>1 error prohibited this venue from being saved:</h2>', response.body
    assert_match "<li>Region must be selected</li>", response.body
  end

  test "should show venue" do
    get venue_url(@venue)
    assert_response :success
  end

  test "should get edit" do
    get edit_venue_url(@venue)
    assert_response :success
  end

  test "should update venue" do
    patch venue_url(@venue), params: {
      venue: {
        region_id: @venue.region_id,
        name: 'New named venue',
        address: @venue.address,
        standard_price: @venue.standard_price,
      }
    }

    assert_redirected_to venue_url(@venue)
    follow_redirect!

    assert_select 'p', "Venue was successfully updated."
    assert_select 'main div p', /Name:.{5}New named venue/m
  end

  test "should alert of update without changes" do
    patch venue_url(@venue), params: {
      venue: {
        region_id: @venue.region_id,
        name: @venue.name,
        address: @venue.address,
        standard_price: @venue.standard_price,
      }
    }

    assert_redirected_to venue_url(@venue)
    follow_redirect!

    assert_select 'p', "No changes made to venue."
  end

  test "should fail to destroy venue with lessons" do
    assert_difference("Venue.count", 0) do
      delete venue_url(@venue)
    end

    assert_redirected_to venue_url(@venue)
    follow_redirect!

    assert_select 'p', "Rejected destruction of venue 'Miramar Community Centre' because it: - has associated lessons."
  end

  test "should destroy venue" do
    delete lesson_url(lessons(:miramar_lesson))

    assert_difference("Venue.count", -1) do
      delete venue_url(@venue)
    end

    assert_redirected_to venues_url
    follow_redirect!

    assert_select 'p', "Venue was successfully destroyed."
  end
end
