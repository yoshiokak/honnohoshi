# frozen_string_literal: true

require "test_helper"

class RakutenBooksBookRatingTest < ActiveSupport::TestCase
  setup do
    @rakuten_books_book_rating = RakutenBooksBookRating.new

    stub_rakuten_books
  end

  test "#service_name" do
    assert_equal("楽天ブックス", @rakuten_books_book_rating.service_name)
  end

  test "#book_exists?" do
    @rakuten_books_book_rating.search("9784101010014")
    assert @rakuten_books_book_rating.book_exists?
  end

  test "#search" do
    @rakuten_books_book_rating.search("9784101010014")
    assert_equal("3.93", @rakuten_books_book_rating.average_rating)
    assert_equal(192, @rakuten_books_book_rating.review_count)
    assert_equal("https://hb.afl.rakuten.co.jp/hgc/g00q0727.zh7wt7c9.g00q0727.zh7wub5e/?pc=https%3A%2F%2Fbooks.rakuten.co.jp%2Frb%2F1656073%2F",
                 @rakuten_books_book_rating.url)
  end

  test "exception handling" do
    stub_rakuten_books_timeout

    assert_not @rakuten_books_book_rating.error
    @rakuten_books_book_rating.search("9784101010014")
    assert @rakuten_books_book_rating.error
  end
end
