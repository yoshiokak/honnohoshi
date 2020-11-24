# frozen_string_literal: true

module StubHelper
  def stub_open_bd
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

  def stub_rakuten_books
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
  end

  def stub_bookmeter_search_results_by_isbn
    stub_request(:get, "https://bookmeter.com/search?keyword=9784101010014").
      with(
        headers: {
          "Accept"=>"*/*",
          "Accept-Encoding"=>"gzip;q=1.0,deflate;q=0.6,identity;q=0.3"
        }
      ).
        to_return(
          status: 200,
          body: File.read(Rails.root.join("test/fixtures/files/bookmeter_search_results_by_isbn.json")),
          headers: { "Content-Type" =>  "application/json" }
        )
  end

  def stub_bookmeter
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
  end

  def stub_hongasuki_search_results_by_isbn
    stub_request(:get, "https://www.honzuki.jp/book/book_search/index.html?search_in=honzuki&isbn=9784101010014").
      with(
        headers: {
          "Accept"=>"*/*",
          "Accept-Encoding"=>"gzip;q=1.0,deflate;q=0.6,identity;q=0.3"
        }
      ).
        to_return(
          status: 200,
          body: File.read(Rails.root.join("test/fixtures/files/hongasuki_search_results_by_isbn.html")),
          headers: { "Content-Type" =>  "text/html" }
        )
  end

  def stub_hongasuki
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

  def stub_amazon
    stub_request(:get, "https://amazon-price1.p.rapidapi.com/search?keywords=9784101010014&marketplace=JP").
      with(
        headers: {
          "Accept"=>"*/*",
          "Accept-Encoding"=>"gzip;q=1.0,deflate;q=0.6,identity;q=0.3"
        }
      ).
        to_return(
          status: 200,
          body: File.read(Rails.root.join("test/fixtures/files/amazon.json")),
          headers: { "Content-Type" =>  "application/json" }
        )
  end
end
