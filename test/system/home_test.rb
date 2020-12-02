# frozen_string_literal: true

require "application_system_test_case"

class HomeTest < ApplicationSystemTestCase
  test "display title" do
    visit root_path

    assert_selector "h1", text: "本の星"
  end
end
