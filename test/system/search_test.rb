# frozen_string_literal: true

require "application_system_test_case"
require "webmock/minitest"

class SearchTest < ApplicationSystemTestCase
  setup do
    WebMock.allow_net_connect!(net_http_connect_on_start: true)
    stub_request(:get, "https://api.openbd.jp/v1/get?isbn=9784101010014").
      with(
        headers: {
              "Accept"=>"*/*",
              "Accept-Encoding"=>"gzip;q=1.0,deflate;q=0.6,identity;q=0.3",
              "User-Agent"=>"Faraday v1.0.1"
        }
      ).
        to_return(
          status: 200,
          body: File.read(Rails.root.join("test/fixtures/files/open_bd.json")),
          headers: { "Content-Type" =>  "application/json" }
        )
  end

  test "search by ISBN-13 to view book information" do
    visit root_path

    fill_in "isbn", with: "9784101010014"
    click_on "検索する"

    assert find("img[src='https://cover.openbd.jp/9784101010014.jpg']")
    assert_text("吾輩は猫である")
    assert_text("夏目漱石／著")
    assert_text("新潮社")
    assert_text("2003-06")
  end

  test "search by ISBN-13 including hyphen to view book information" do
    visit root_path

    fill_in "isbn", with: "978-4101010014"
    click_on "検索する"

    assert find("img[src='https://cover.openbd.jp/9784101010014.jpg']")
    assert_text("吾輩は猫である")
    assert_text("夏目漱石／著")
    assert_text("新潮社")
    assert_text("2003-06")
  end

  test "search by ISBN-10 to view book information" do
    visit root_path

    fill_in "isbn", with: "4101010013"
    click_on "検索する"

    assert find("img[src='https://cover.openbd.jp/9784101010014.jpg']")
    assert_text("吾輩は猫である")
    assert_text("夏目漱石／著")
    assert_text("新潮社")
    assert_text("2003-06")
  end

  test "search by invalid string to view error message" do
    visit root_path

    fill_in "isbn", with: "invalidstring"
    click_on "検索する"

    assert_text("ISBN-13またはISBN-10を入力してください")
  end

  test "search by nonexistent ISBN to view error message" do
    visit root_path

    fill_in "isbn", with: "9784101010013"
    click_on "検索する"

    assert_text("書籍が見つかりませんでした")
  end

  test "when visit root_path, don't view error message" do
    visit root_path

    assert_no_text("ISBN-13またはISBN-10を入力してください")
    assert_no_text("書籍が見つかりませんでした")
  end

  test "search by ISBN to view RakutenBooks rating" do
    stub_request(:get, "https://app.rakuten.co.jp/services/api/BooksBook/Search/20170404?affiliateId=#{ENV["RAKUTEN_AFFILIATE_ID"]}&applicationId=#{ENV["RAKUTEN_APP_ID"]}&formatVersion=2&isbn=9784101010014").
      with(
        headers: {
          "Accept"=>"*/*",
          "Accept-Encoding"=>"gzip;q=1.0,deflate;q=0.6,identity;q=0.3"
        }
      ).
        to_return(
          status: 200,
          body: File.read(Rails.root.join("test/fixtures/files/rakuten_books.json")),
          headers: { "Content-Type" =>  "application/json" }
        )

    visit root_path

    fill_in "isbn", with: "978-4101010014"
    click_on "検索する"

    assert page.all(".book-reviews__star-rating")[0]
    assert_equal("3.93", page.all(".book-reviews__average-rating")[0].text)
    assert_equal("(レビュー192件)", page.all(".book-reviews__review-count")[0].text)
    assert has_link?("楽天ブックス")
  end

  test "search by ISBN to view Bookmeter rating" do
    @bookmeter = Bookmeter.new("9784101010014")

    stub_request(:get, "https://bookmeter.com/search?keyword=9784101010014").
      with(
        headers: {
          "Accept"=>"*/*",
          "Accept-Encoding"=>"gzip;q=1.0,deflate;q=0.6,identity;q=0.3"
        }
      ).
        to_return(
          status: 200,
          body: File.read(Rails.root.join("test/fixtures/files/bookmeter.json")),
          headers: { "Content-Type" =>  "application/json" }
        )

    stub_request(:get, "https://bookmeter.com/books/548397").
      with(
        headers: {
          "Accept"=>"*/*",
          "Accept-Encoding"=>"gzip;q=1.0,deflate;q=0.6,identity;q=0.3"
        }
      ).
        to_return(
          status: 200,
          body: File.read(Rails.root.join("test/fixtures/files/bookmeter.html")),
          headers: { "Content-Type" =>  "text/html" }
        )

    visit root_path

    fill_in "isbn", with: "978-4101010014"
    click_on "検索する"

    assert page.all(".book-reviews__star-rating")[1]
    assert_equal("4.1", page.all(".book-reviews__average-rating")[1].text)
    assert_equal("(レビュー1094件)", page.all(".book-reviews__review-count")[1].text)
    assert has_link?("読書メーター")
  end
end
