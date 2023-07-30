require "test_helper"

class RegionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @region = regions(:wellington)
  end

  test "should get index" do
    get regions_url
    assert_response :success
  end

  test "should get new" do
    get new_region_url
    assert_response :success
  end

  test "should create region" do
    assert_difference("Region.count", 1) do
      post regions_url, params: default_region_params
    end

    assert_redirected_to regions_url
    follow_redirect!

    assert_select 'p', "Region was successfully created."
    assert_select 'h1', 'Regions'
    assert_select 'li.list-group-item', 'Auckland'
  end

  test "should fail to create region with missing name" do
    assert_difference("Region.count", 0) do
      post regions_url, params: { region: { name: '' } }
    end

    assert_response 422

    assert_select 'h1', 'New region'
    assert_select 'h2', '1 error prohibited this region from being saved:'
    assert_select 'li', "Name can't be blank"
  end

  test "should fail to create region with duplicate name" do
    assert_difference("Region.count", 0) do
      post regions_url, params: { region: { name: 'Wellington' } }
    end

    assert_response 422

    assert_select 'h1', 'New region'
    assert_select 'h2', '1 error prohibited this region from being saved:'
    assert_select 'li', 'Name has already been taken'
  end

  test "should show region" do
    get region_url(@region)
    assert_response :success
  end

  test "should get edit" do
    get edit_region_url(@region)
    assert_response :success
  end

  test "should update region" do
    patch region_url(@region), params: { region: { name: 'Auckland' } }

    assert_redirected_to regions_url
    follow_redirect!

    assert_select 'p', "Region was successfully updated."
    assert_select 'li.list-group-item', 'Auckland'
  end

  test "should alert of update without changes" do
    patch region_url(@region), params: { region: { name: @region.name } }

    assert_redirected_to regions_url
    follow_redirect!

    assert_select 'p', "No changes made to region."
  end

  test "should fail to update region when missing params" do
    patch region_url(@region), params: { region: { name: '' } }

    assert_response 422

    assert_select 'h1', 'Editing region'
    assert_select 'h2', '1 error prohibited this region from being saved:'
    assert_select 'li', "Name can't be blank"

    assert_select 'form div.field_with_errors label', 'Name'
    assert_select 'form div.field_with_errors input', ''
  end

  test "should fail to destroy region with associations" do
    assert_difference("Region.count", 0) do
      delete region_url(@region)
    end

    assert_redirected_to regions_url
    follow_redirect!

    assert_select 'p', "Rejected destruction of region 'Wellington' because it: - has associated venues. - has associated tutors. - has associated students. - has associated contacts."
  end

  test "should destroy region" do
    assert_difference("Region.count", 1) do
      post regions_url, params: default_region_params
    end

    assert_difference("Region.count", -1) do
      delete region_url(Region.last)
    end

    assert_redirected_to regions_url
    follow_redirect!

    assert_select 'p', 'Region was successfully destroyed.'
  end
end
