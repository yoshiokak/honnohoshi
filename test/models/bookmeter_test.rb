# frozen_string_literal: true

require "test_helper"
require "webmock/minitest"

class BookmeterTest < ActiveSupport::TestCase
  setup do
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
  end

  test "#name" do
    assert_equal("読書メーター", @bookmeter.name)
  end

  test "#book_exists?" do
    assert @bookmeter.book_exists?
  end

  test "#fetch" do
    @bookmeter.fetch
    assert_equal("https://bookmeter.com/books/548397", @bookmeter.url)
    assert_equal(4.1, @bookmeter.average_rating)
    assert_equal("1094", @bookmeter.review_count)
  end
end
