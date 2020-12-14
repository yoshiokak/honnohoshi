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

  test "exception handling when searching" do
    stub_hongasuki_search_results_by_isbn_timeout

    assert_not @hongasuki_book_rating.error
    @hongasuki_book_rating.search("9784101010014")
    assert @hongasuki_book_rating.error
  end

  test "exception handling when parsing" do
    stub_hongasuki_timeout

    @hongasuki_book_rating.search("9784101010014")
    assert_equal("取得エラー", @hongasuki_book_rating.average_rating)
    assert_equal("取得エラー", @hongasuki_book_rating.review_count)
  end

  test "book rating is not available in Hongasuki" do
    stub_book_rating_is_not_available_in_Hongasuki

    @hongasuki_book_rating.search("9784781912295")
    assert_equal("評価なし", @hongasuki_book_rating.average_rating)
    assert_equal("0", @hongasuki_book_rating.review_count)
  end
end
