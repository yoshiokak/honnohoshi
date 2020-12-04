# frozen_string_literal: true

class AmazonBookRating < BookRating
  attr_reader :average_rating, :review_count, :url

  def service_name
    "Amazon"
  end

  def book_exists?
    !@book.nil?
  end

  def search(isbn)
    @book = RakutenRapidAPI::AmazonPrice.search(isbn).first

    if book_exists?
      @url = @book["detailPageURL"]
      @average_rating = @book["rating"]
      @review_count = @book["totalReviews"]
    end
  end
end
