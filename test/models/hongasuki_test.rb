# frozen_string_literal: true

require "test_helper"
require "webmock/minitest"

class HongasukiTest < ActiveSupport::TestCase
  setup do
    @hongasuki = Hongasuki.new

    stub_hongasuki_search_results_by_isbn
    stub_hongasuki
  end

  test "#name" do
    assert_equal("本が好き！", @hongasuki.name)
  end

  test "#book_exists?" do
    @hongasuki.search("9784101010014")
    assert @hongasuki.book_exists?
  end

  test "#search" do
    @hongasuki.search("9784101010014")
    assert_equal("https://www.honzuki.jp/book/9931/", @hongasuki.url)
    assert_equal("4.11", @hongasuki.average_rating)
    assert_equal("10", @hongasuki.review_count)
  end
end
