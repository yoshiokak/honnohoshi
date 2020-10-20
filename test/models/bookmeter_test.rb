# frozen_string_literal: true

require "test_helper"
require "webmock/minitest"

class BookmeterTest < ActiveSupport::TestCase
  setup do
    @bookmeter = Bookmeter.new("9784101010014")

    stub_bookmeter_search_results_by_isbn
    stub_bookmeter
  end

  test "#name" do
    assert_equal("読書メーター", @bookmeter.name)
  end

  test "#book_exists?" do
    assert @bookmeter.book_exists?
  end

  test "#fetch" do
    @bookmeter.fetch
    assert_equal("https://bookmeter.com/books/548397", @bookmeter.url)
    assert_equal(4.1, @bookmeter.average_rating)
    assert_equal("1094", @bookmeter.review_count)
  end
end
