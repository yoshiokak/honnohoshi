# frozen_string_literal: true

require "test_helper"

module RakutenBooks
  class BooksearcherTest < ActiveSupport::TestCase
    setup do
      stub_rakuten_books
    end

    test ".search" do
      book = RakutenBooks::BookSearcher.search("9784101010014")

      assert_equal("https://thumbnail.image.rakuten.co.jp/@0_mall/book/cabinet/0014/9784101010014.jpg?_ex=200x200", book.cover_image)
      assert_equal("新潮社", book.publisher)
      assert_equal("2003年06月", book.release_date)
      assert_equal("吾輩は猫である改版", book.title)
      assert_equal("夏目漱石", book.author)
      assert_equal("9784101010014", book.isbn13)
    end
  end
end
