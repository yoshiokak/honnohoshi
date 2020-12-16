# frozen_string_literal: true

require "test_helper"

class AmazonBookRatingTest < ActiveSupport::TestCase
  setup do
    @amazon_book_rating = AmazonBookRating.new

    stub_amazon
  end

  test "#service_name" do
    assert_equal("Amazon", @amazon_book_rating.service_name)
  end

  test "#book_exists?" do
    @amazon_book_rating.search("9784101010014")
    assert @amazon_book_rating.book_exists?
  end

  test "#search" do
    @amazon_book_rating.search("9784101010014")
    assert_equal("https://www.amazon.co.jp/dp/B00CL6N16Q", @amazon_book_rating.url)
    assert_equal("3.9", @amazon_book_rating.average_rating)
    assert_equal("762", @amazon_book_rating.review_count)
  end

  test "exception handling" do
    stub_amazon_timeout

    assert_not @amazon_book_rating.error
    @amazon_book_rating.search("9784101010014")
    assert @amazon_book_rating.error
  end

  test "book rating is not available in Amazon" do
    stub_book_rating_is_not_available_in_amazon

    @amazon_book_rating.search("9784326199808")
    assert_equal("評価なし", @amazon_book_rating.average_rating)
    assert_equal("0", @amazon_book_rating.review_count)
    assert_equal("https://www.amazon.co.jp/dp/4326199806",
                 @amazon_book_rating.url)
  end
end
