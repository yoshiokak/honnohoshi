# frozen_string_literal: true

require "test_helper"
require "webmock/minitest"

class ServiceTest < ActiveSupport::TestCase
  setup do
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

    stub_request(:get, "https://www.honzuki.jp/book/book_search/index.html?search_in=honzuki&isbn=9784101010014").
      with(
        headers: {
          "Accept"=>"*/*",
          "Accept-Encoding"=>"gzip;q=1.0,deflate;q=0.6,identity;q=0.3"
        }
      ).
        to_return(
          status: 200,
          body: File.read(Rails.root.join("test/fixtures/files/hongasuki_search_url.html")),
          headers: { "Content-Type" =>  "text/html" }
        )

    stub_request(:get, "https://www.honzuki.jp/book/9931/").
      with(
        headers: {
          "Accept"=>"*/*",
          "Accept-Encoding"=>"gzip;q=1.0,deflate;q=0.6,identity;q=0.3"
        }
      ).
        to_return(
          status: 200,
          body: File.read(Rails.root.join("test/fixtures/files/hongasuki.html")),
          headers: { "Content-Type" =>  "text/html" }
        )
  end

  test ".search" do
    services = Service.search("9784101010014")

    assert services[0].kind_of?(RakutenBooks)
    assert services[1].kind_of?(Bookmeter)
    assert services[2].kind_of?(Hongasuki)
  end
end
