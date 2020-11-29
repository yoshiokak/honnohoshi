# frozen_string_literal: true

require "test_helper"
require "webmock/minitest"

class RakutenBooksTest < ActiveSupport::TestCase
  setup do
    @rakuten_books = RakutenBooks.new("9784101010014")

    stub_rakuten_books
  end

  test "#name" do
    assert_equal("楽天ブックス", @rakuten_books.name)
  end

  test "#book_exists?" do
    @rakuten_books.fetch
    assert @rakuten_books.book_exists?
  end

  test "#fetch" do
    @rakuten_books.fetch
    assert_equal("3.93", @rakuten_books.average_rating)
    assert_equal(192, @rakuten_books.review_count)
    assert_equal("https://hb.afl.rakuten.co.jp/hgc/g00q0727.zh7wt7c9.g00q0727.zh7wub5e/?pc=https%3A%2F%2Fbooks.rakuten.co.jp%2Frb%2F1656073%2F",
                 @rakuten_books.url)
  end
end
