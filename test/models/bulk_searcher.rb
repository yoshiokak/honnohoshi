# frozen_string_literal: true

require "test_helper"

class BulkSearcherTest < ActiveSupport::TestCase
  setup do
    stub_amazon
    stub_rakuten_books
    stub_bookmeter_search_results_by_isbn
    stub_bookmeter
    stub_hongasuki_search_results_by_isbn
    stub_hongasuki
  end

  test ".search" do
    services = BulkSearcher.search("9784101010014")

    assert services[0].kind_of?(AmazonBookRating)
    assert services[1].kind_of?(RakutenBooksBookRating)
    assert services[2].kind_of?(BookmeterBookRating)
    assert services[3].kind_of?(HongasukiBookRating)
  end
end
