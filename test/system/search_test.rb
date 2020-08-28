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
end