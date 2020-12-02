# frozen_string_literal: true

require "test_helper"

class HongasukiBookRatingTest < ActiveSupport::TestCase
  setup do
    @hongasuki_book_rating = HongasukiBookRating.new

    stub_hongasuki_search_results_by_isbn
    stub_hongasuki
  end

  test "#service_name" do
    assert_equal("本が好き！", @hongasuki_book_rating.service_name)
  end

  test "#book_exists?" do
    @hongasuki_book_rating.search("9784101010014")
    assert @hongasuki_book_rating.book_exists?
  end

  test "#search" do
    @hongasuki_book_rating.search("9784101010014")
    assert_equal("https://www.honzuki.jp/book/9931/", @hongasuki_book_rating.url)
    assert_equal("4.11", @hongasuki_book_rating.average_rating)
    assert_equal("10", @hongasuki_book_rating.review_count)
  end
end
