# frozen_string_literal: true

require "application_system_test_case"

class HelpTest < ApplicationSystemTestCase
  test "display image" do
    visit help_path

    within(".help") do
      assert_selector "img"
    end
  end
end
