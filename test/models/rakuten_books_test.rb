# frozen_string_literal: true

require "test_helper"
require "webmock/minitest"

class RakutenBooksTest < ActiveSupport::TestCase
  setup do
    @rakuten_books = RakutenBooks.new("9784101010014")

    stub_request(:get, "https://app.rakuten.co.jp/services/api/BooksBook/Search/20170404?
                        affiliateId=#{ENV["RAKUTEN_AFFILIATE_ID"]}&applicationId=#{ENV["RAKUTEN_APP_ID"]}&formatVersion=2&isbn=9784101010014").
  with(
    headers: {
          "Accept"=>"*/*",
          "Accept-Encoding"=>"gzip;q=1.0,deflate;q=0.6,identity;q=0.3",
          "User-Agent"=>"RakutenWebService SDK for Ruby v1.12.0(ruby-2.7.1 [x86_64-darwin18])"
    }).
    to_return(
      status: 200,
      body: File.read(Rails.root.join("test/fixtures/files/rakuten_books.json")),
      headers: { "Content-Type" =>  "application/json" }
    )
  end

  test "#name" do
    assert_equal("楽天ブックス", @rakuten_books.name)
  end

  test "#book" do
    assert @rakuten_books.book
  end

  test "#average_rating" do
    assert_equal("3.93", @rakuten_books.average_rating)
  end

  test "#review_count" do
    assert_equal(192, @rakuten_books.review_count)
  end

  test "#url" do
    assert_equal("https://hb.afl.rakuten.co.jp/hgc/g00q0727.zh7wt7c9.g00q0727.zh7wub5e/?pc=https%3A%2F%2Fbooks.rakuten.co.jp%2Frb%2F1656073%2F",
                 @rakuten_books.url)
  end
end
