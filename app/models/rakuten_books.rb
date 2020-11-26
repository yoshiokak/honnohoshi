# frozen_string_literal: true

class RakutenBooks
  attr_reader :average_rating, :review_count, :url

  def initialize(isbn)
    @isbn = isbn
  end

  def fetch
    book = RakutenWebService::Books::Book.search(isbn: @isbn).first

    @url = book.affiliate_url
    @average_rating = book.review_average
    @review_count = book.review_count
  end

  def book_exists?
    !RakutenWebService::Books::Book.search(isbn: @isbn).first.nil?
  end

  def name
    "楽天ブックス"
  end
end
