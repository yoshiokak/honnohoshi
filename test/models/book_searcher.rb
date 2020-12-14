# frozen_string_literal: true

require "test_helper"

class BookSearcherTest < ActiveSupport::TestCase
  setup do
    stub_open_bd
    stub_rakuten_books
  end

  test ".search" do
    book = BookSearcher.search("9784101010014")

    assert_equal("https://cover.openbd.jp/9784101010014.jpg", book.cover_image)
    assert_equal("新潮社", book.publisher)
    assert_equal("2003-06", book.release_date)
    assert_equal("吾輩は猫である", book.title)
    assert_equal("夏目漱石／著", book.author)
    assert_equal("9784101010014", book.isbn13)
  end

  test "no image of book in OpenBD" do
    stub_no_image_of_book_in_open_bd

    book = BookSearcher.search("9784062748681")

    assert_equal("https://thumbnail.image.rakuten.co.jp/@0_mall/book/cabinet/8681/9784062748681.jpg?_ex=200x200", book.cover_image)
    assert_equal("講談社", book.publisher)
    assert_equal("20040914", book.release_date)
    assert_equal("ノルウェイの森（上）", book.title)
    assert_equal("村上春樹／著", book.author)
    assert_equal("9784062748681", book.isbn13)
  end

  test "book not in OpenBD" do
    stub_book_not_in_open_bd

    book = BookSearcher.search("9784295008583")

    assert_equal("https://thumbnail.image.rakuten.co.jp/@0_mall/book/cabinet/8583/9784295008583.jpg?_ex=200x200", book.cover_image)
    assert_equal("インプレス", book.publisher)
    assert_equal("2020年03月", book.release_date)
    assert_equal("マイクロサービスパターン", book.title)
    assert_equal("クリス・リチャードソン/長尾高弘", book.author)
    assert_equal("9784295008583", book.isbn13)
  end

  test "book not in OpenBD and RakutenBooks" do
    stub_book_not_in_open_bd_and_rakuten_books

    book = BookSearcher.search("9784004200369")

    assert book == nil
  end

  test "search by ISBN-13 including hyphen return book information" do
    book = BookSearcher.search("978-4101010014")

    assert_equal("https://cover.openbd.jp/9784101010014.jpg", book.cover_image)
    assert_equal("新潮社", book.publisher)
    assert_equal("2003-06", book.release_date)
    assert_equal("吾輩は猫である", book.title)
    assert_equal("夏目漱石／著", book.author)
    assert_equal("9784101010014", book.isbn13)
  end

  test "search by ISBN-10 return book information" do
    book = BookSearcher.search("4101010013")

    assert_equal("https://cover.openbd.jp/9784101010014.jpg", book.cover_image)
    assert_equal("新潮社", book.publisher)
    assert_equal("2003-06", book.release_date)
    assert_equal("吾輩は猫である", book.title)
    assert_equal("夏目漱石／著", book.author)
    assert_equal("9784101010014", book.isbn13)
  end

  test "no book image in OpenBD and RakutenBooks" do
    stub_no_book_image_in_open_bd_and_rakuten_books

    book = BookSearcher.search("9784423196267")

    assert_equal("/assets/not_available.png", book.cover_image)
  end
end
