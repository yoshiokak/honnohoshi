# frozen_string_literal: true

require "application_system_test_case"

class DisclaimerTest < ApplicationSystemTestCase
  test "display h1" do
    visit disclaimer_path

    assert_selector "h1", text: "免責事項"
  end
end
