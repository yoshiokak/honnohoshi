# frozen_string_literal: true

require "test_helper"
require "webmock/minitest"

class ServiceTest < ActiveSupport::TestCase
  setup do
    stub_amazon
    stub_rakuten_books
    stub_bookmeter_search_results_by_isbn
    stub_bookmeter
    stub_hongasuki_search_results_by_isbn
    stub_hongasuki
  end

  test ".search" do
    services = Service.search("9784101010014")

    assert services[0].kind_of?(Amazon)
    assert services[1].kind_of?(RakutenBooks)
    assert services[2].kind_of?(Bookmeter)
    assert services[3].kind_of?(Hongasuki)
  end
end
