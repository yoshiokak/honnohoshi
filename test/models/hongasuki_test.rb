# frozen_string_literal: true

require "test_helper"
require "webmock/minitest"

class HongasukiTest < ActiveSupport::TestCase
  setup do
    @hongasuki = Hongasuki.new("9784101010014")

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

  test "#name" do
    assert_equal("本が好き！", @hongasuki.name)
  end

  test "#book_exists?" do
    assert @hongasuki.book_exists?
  end

  test "#fetch" do
    @hongasuki.fetch
    assert_equal("https://www.honzuki.jp/book/9931/", @hongasuki.url)
    assert_equal("4.11", @hongasuki.average_rating)
    assert_equal("10", @hongasuki.review_count)
  end
end
