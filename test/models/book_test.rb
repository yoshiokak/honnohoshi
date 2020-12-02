# frozen_string_literal: true

require "test_helper"

class BookTest < ActiveSupport::TestCase
  setup do
    stub_open_bd
  end

  test "#search" do
    book = Book.new.search("9784101010014")

    assert_equal("https://cover.openbd.jp/9784101010014.jpg", book.cover_image)
    assert_equal("新潮社", book.publisher)
    assert_equal("2003-06", book.release_date)
    assert_equal("吾輩は猫である", book.title)
    assert_equal("夏目漱石／著", book.author)
    assert_equal("9784101010014", book.isbn13)
  end

  test "#exists?" do
    book = Book.new.search("9784101010014")

    assert book.exists?
  end

  test "search by ISBN-13 including hyphen return book information" do
    book = Book.new.search("978-4101010014")

    assert_equal("https://cover.openbd.jp/9784101010014.jpg", book.cover_image)
    assert_equal("新潮社", book.publisher)
    assert_equal("2003-06", book.release_date)
    assert_equal("吾輩は猫である", book.title)
    assert_equal("夏目漱石／著", book.author)
    assert_equal("9784101010014", book.isbn13)
  end

  test "search by ISBN-10 return book information" do
    book = Book.new.search("4101010013")

    assert_equal("https://cover.openbd.jp/9784101010014.jpg", book.cover_image)
    assert_equal("新潮社", book.publisher)
    assert_equal("2003-06", book.release_date)
    assert_equal("吾輩は猫である", book.title)
    assert_equal("夏目漱石／著", book.author)
    assert_equal("9784101010014", book.isbn13)
  end
end
