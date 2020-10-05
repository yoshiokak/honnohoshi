# frozen_string_literal: true

class RakutenBooks
  attr_reader :average_rating, :review_count, :url

  def initialize(isbn)
    @isbn = isbn
  end

  def fetch
    if book_exists?
      book = RakutenWebService::Books::Book.search(isbn: @isbn).first

      @url = book.affiliate_url
      @average_rating = book.review_average
      @review_count = book.review_count
    end
  end

  def book_exists?
    if RakutenWebService::Books::Book.search(isbn: @isbn).first.nil?
      false
    else
      true
    end
  end

  def name
    "楽天ブックス"
  end
end
