# frozen_string_literal: true

class Amazon
  attr_reader :average_rating, :review_count, :url

  def initialize(isbn)
    @isbn = isbn
  end

  def fetch
    @book = RakutenRapidAPI::AmazonPrice.search(@isbn).first

    if book_exists?
      @url = @book["detailPageURL"]
      @average_rating = @book["rating"]
      @review_count = @book["totalReviews"]
    end
  end

  def book_exists?
    !@book.nil?
  end

  def name
    "Amazon"
  end
end
