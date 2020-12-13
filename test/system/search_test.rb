# frozen_string_literal: true

require "application_system_test_case"

class SearchTest < ApplicationSystemTestCase
  setup do
    stub_open_bd
    stub_amazon
    stub_rakuten_books
    stub_bookmeter_search_results_by_isbn
    stub_bookmeter
    stub_hongasuki_search_results_by_isbn
    stub_hongasuki
  end

  test "search by ISBN-13 to view book information and book ratings" do
    visit root_path

    fill_in "isbn", with: "9784101010014"
    find(".search__btn").click

    assert find("img[src='https://cover.openbd.jp/9784101010014.jpg']")
    assert_text("吾輩は猫である")
    assert_text("夏目漱石／著")
    assert_text("新潮社")
    assert_text("2003-06")

    assert_selector(".book-ratings__logo-0")
    assert page.all(".book-ratings__star-rating")[0]
    assert_equal("3.9", page.all(".book-ratings__average-rating")[0].text)
    assert_equal("(レビュー762件)", page.all(".book-ratings__review-count")[0].text)
    page.assert_selector(:link, nil, href: "https://www.amazon.co.jp/dp/B00CL6N16Q")

    assert_selector(".book-ratings__logo-1")
    assert page.all(".book-ratings__star-rating")[1]
    assert_equal("3.93", page.all(".book-ratings__average-rating")[1].text)
    assert_equal("(レビュー192件)", page.all(".book-ratings__review-count")[1].text)
    page.assert_selector(:link, nil, href: "https://hb.afl.rakuten.co.jp/hgc/g00q0727.zh7wt7c9.g00q0727.zh7wub5e/?pc=https%3A%2F%2Fbooks.rakuten.co.jp%2Frb%2F1656073%2F")

    assert_selector(".book-ratings__logo-2")
    assert page.all(".book-ratings__star-rating")[2]
    assert_equal("4.1", page.all(".book-ratings__average-rating")[2].text)
    assert_equal("(レビュー1094件)", page.all(".book-ratings__review-count")[2].text)
    page.assert_selector(:link, nil, href: "https://bookmeter.com/books/548397")

    assert_selector(".book-ratings__logo-3")
    assert page.all(".book-ratings__star-rating")[3]
    assert_equal("4.11", page.all(".book-ratings__average-rating")[3].text)
    assert_equal("(レビュー10件)", page.all(".book-ratings__review-count")[3].text)
    page.assert_selector(:link, nil, href: "https://www.honzuki.jp/book/9931/")
  end

  test "search by invalid string to view error message" do
    visit root_path

    fill_in "isbn", with: "invalidstring"
    find(".search__btn").click

    assert_text("有効なISBN-13または有効なISBN-10を入力してください")
  end

  test "search by nonexistent ISBN to view error message" do
    visit root_path

    fill_in "isbn", with: "9784101010013"
    find(".search__btn").click

    assert_text("有効なISBN-13または有効なISBN-10を入力してください")
  end

  test "when visit search_path, view error message" do
    visit search_path

    assert_text("有効なISBN-13または有効なISBN-10を入力してください")
  end

  test "book not in OpenBD and RakutenBooks" do
    stub_book_not_in_open_bd_and_rakuten_books

    visit root_path

    fill_in "isbn", with: "9784004200369"
    find(".search__btn").click

    assert_text("書籍が見つかりませんでした")
  end

  test "book not in OpenBD and RakutenBooks" do
    stub_book_not_in_open_bd_and_rakuten_books

    visit root_path

    fill_in "isbn", with: "9784004200369"
    find(".search__btn").click

    assert_text("書籍が見つかりませんでした")
  end
end
