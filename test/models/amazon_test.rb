# frozen_string_literal: true

require "test_helper"
require "webmock/minitest"

class AmazonTest < ActiveSupport::TestCase
  setup do
    @amazon = Amazon.new("9784101010014")

    stub_amazon
  end

  test "#name" do
    assert_equal("Amazon", @amazon.name)
  end

  test "#book_exists?" do
    @amazon.fetch
    assert @amazon.book_exists?
  end

  test "#fetch" do
    @amazon.fetch
    assert_equal("https://www.amazon.co.jp/dp/B00CL6N16Q", @amazon.url)
    assert_equal("3.9", @amazon.average_rating)
    assert_equal("762", @amazon.review_count)
  end
end
