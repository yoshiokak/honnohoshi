# frozen_string_literal: true

require "test_helper"

class AmazonTest < ActiveSupport::TestCase
  setup do
    stub_amazon
  end

  test ".search" do
    assert_equal(JSON.parse(File.read(Rails.root.join("test/fixtures/files/amazon.json"))),
                 RakutenRapidAPI::AmazonPrice.search("9784101010014"))
  end
end
