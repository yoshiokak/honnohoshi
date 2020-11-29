# frozen_string_literal: true

require "test_helper"
require "webmock/minitest"

class BookTest < ActiveSupport::TestCase
  setup do
    stub_open_bd
  end

  test "#fetch" do
    book = Book.new("9784101010014")
    book.fetch

    assert_equal("https://cover.openbd.jp/9784101010014.jpg", book.cover_image)
    assert_equal("新潮社", book.publisher)
    assert_equal("2003-06", book.release_date)
    assert_equal("吾輩は猫である", book.title)
    assert_equal("夏目漱石／著", book.author)
    assert_equal("9784101010014", book.isbn13)
  end

  test "#exists?" do
    book = Book.new("9784101010014")
    book.fetch

    assert book.exists?
  end
end
