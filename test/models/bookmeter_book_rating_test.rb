# frozen_string_literal: true

require "test_helper"
require "webmock/minitest"

class BookmeterBookRatingTest < ActiveSupport::TestCase
  setup do
    @bookmeter_book_rating = BookmeterBookRating.new

    stub_bookmeter_search_results_by_isbn
    stub_bookmeter
  end

  test "#service_name" do
    assert_equal("読書メーター", @bookmeter_book_rating.service_name)
  end

  test "#book_exists?" do
    @bookmeter_book_rating.search("9784101010014")
    assert @bookmeter_book_rating.book_exists?
  end

  test "#search" do
    @bookmeter_book_rating.search("9784101010014")
    assert_equal("https://bookmeter.com/books/548397", @bookmeter_book_rating.url)
    assert_equal(4.1, @bookmeter_book_rating.average_rating)
    assert_equal("1094", @bookmeter_book_rating.review_count)
  end
end
