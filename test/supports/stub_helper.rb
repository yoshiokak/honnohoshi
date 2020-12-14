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

    stub_request(:get, "https://api.openbd.jp/v1/get?isbn=4101010013").
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

  def stub_rakuten_books_timeout
    stub_request(:get, "https://app.rakuten.co.jp/services/api/BooksBook/Search/20170404?affiliateId=#{ENV["RAKUTEN_AFFILIATE_ID"]}&applicationId=#{ENV["RAKUTEN_APP_ID"]}&formatVersion=2&isbn=9784101010014").to_timeout
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

  def stub_bookmeter_search_results_by_isbn_timeout
    stub_request(:get, "https://bookmeter.com/search?keyword=9784101010014").to_raise(Net::OpenTimeout)
  end

  def stub_bookmeter_timeout
    stub_request(:get, "https://bookmeter.com/books/548397").to_raise(Net::OpenTimeout)
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

  def stub_hongasuki_search_results_by_isbn_timeout
    stub_request(:get, "https://www.honzuki.jp/book/book_search/index.html?search_in=honzuki&isbn=9784101010014").to_raise(Net::OpenTimeout)
  end

  def stub_hongasuki_timeout
    stub_request(:get, "https://www.honzuki.jp/book/9931/").to_raise(Net::OpenTimeout)
  end

  def stub_book_rating_is_not_available_in_Hongasuki
    stub_request(:get, "https://www.honzuki.jp/book/book_search/index.html?search_in=honzuki&isbn=9784781912295").
      with(
        headers: {
          "Accept"=>"*/*",
          "Accept-Encoding"=>"gzip;q=1.0,deflate;q=0.6,identity;q=0.3"
        }
      ).
        to_return(
          status: 200,
          body: File.read(Rails.root.join("test/fixtures/files/hongasuki_search_results_by_isbn_9784781912295.html")),
          headers: { "Content-Type" =>  "text/html" }
        )
    stub_request(:get, "https://www.honzuki.jp/book/45397/").
      with(
        headers: {
          "Accept"=>"*/*",
          "Accept-Encoding"=>"gzip;q=1.0,deflate;q=0.6,identity;q=0.3"
        }
      ).
        to_return(
          status: 200,
          body: File.read(Rails.root.join("test/fixtures/files/hongasuki_isbn_9784781912295.html")),
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

  def stub_amazon_timeout
    stub_request(:get, "https://amazon-price1.p.rapidapi.com/search?keywords=9784101010014&marketplace=JP").to_raise(Net::OpenTimeout)
  end

  def stub_no_image_of_book_in_open_bd
    stub_request(:get, "https://api.openbd.jp/v1/get?isbn=9784062748681").
      with(
        headers: {
              "Accept"=>"*/*",
              "Accept-Encoding"=>"gzip;q=1.0,deflate;q=0.6,identity;q=0.3",
              "User-Agent"=>"Faraday v1.0.1"
        }
      ).
        to_return(
          status: 200,
          body: File.read(Rails.root.join("test/fixtures/files/isbn_9784062748681_on_open_bd.json")),
          headers: { "Content-Type" =>  "application/json" }
        )

    stub_request(:get, "https://app.rakuten.co.jp/services/api/BooksTotal/Search/20170404?format=json&isbnjan=9784062748681&applicationId=#{ENV["RAKUTEN_APP_ID"]}").
      with(
        headers: {
          "Accept"=>"*/*",
          "Accept-Encoding"=>"gzip;q=1.0,deflate;q=0.6,identity;q=0.3"
        }
      ).
        to_return(
          status: 200,
          body: File.read(Rails.root.join("test/fixtures/files/isbn_9784062748681_on_rakuten_books.json")),
          headers: { "Content-Type" =>  "application/json" }
        )
  end

  def stub_book_not_in_open_bd
    stub_request(:get, "https://api.openbd.jp/v1/get?isbn=9784295008583").
      with(
        headers: {
              "Accept"=>"*/*",
              "Accept-Encoding"=>"gzip;q=1.0,deflate;q=0.6,identity;q=0.3",
              "User-Agent"=>"Faraday v1.0.1"
        }
      ).
        to_return(
          status: 200,
          body: File.read(Rails.root.join("test/fixtures/files/isbn_9784295008583_on_open_bd.json")),
          headers: { "Content-Type" =>  "application/json" }
        )

    stub_request(:get, "https://app.rakuten.co.jp/services/api/BooksTotal/Search/20170404?format=json&isbnjan=9784295008583&applicationId=#{ENV["RAKUTEN_APP_ID"]}").
      with(
        headers: {
          "Accept"=>"*/*",
          "Accept-Encoding"=>"gzip;q=1.0,deflate;q=0.6,identity;q=0.3"
        }
      ).
        to_return(
          status: 200,
          body: File.read(Rails.root.join("test/fixtures/files/isbn_9784295008583_on_rakuten_books.json")),
          headers: { "Content-Type" =>  "application/json" }
        )
  end

  def stub_book_not_in_open_bd_and_rakuten_books
    stub_request(:get, "https://api.openbd.jp/v1/get?isbn=9784004200369").
      with(
        headers: {
              "Accept"=>"*/*",
              "Accept-Encoding"=>"gzip;q=1.0,deflate;q=0.6,identity;q=0.3",
              "User-Agent"=>"Faraday v1.0.1"
        }
      ).
        to_return(
          status: 200,
          body: File.read(Rails.root.join("test/fixtures/files/isbn_9784004200369_on_open_bd.json")),
          headers: { "Content-Type" =>  "application/json" }
        )

    stub_request(:get, "https://app.rakuten.co.jp/services/api/BooksTotal/Search/20170404?format=json&isbnjan=9784004200369&applicationId=#{ENV["RAKUTEN_APP_ID"]}").
      with(
        headers: {
          "Accept"=>"*/*",
          "Accept-Encoding"=>"gzip;q=1.0,deflate;q=0.6,identity;q=0.3"
        }
      ).
        to_return(
          status: 200,
          body: File.read(Rails.root.join("test/fixtures/files/isbn_9784004200369_on_rakuten_books.json")),
          headers: { "Content-Type" =>  "application/json" }
        )
  end
end
