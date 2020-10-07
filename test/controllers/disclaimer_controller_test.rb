# frozen_string_literal: true

require "test_helper"

class DisclaimerControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get disclaimer_index_url
    assert_response :success
  end
end
