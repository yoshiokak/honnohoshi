# frozen_string_literal: true

class AmazonBookRating < BookRating
  attr_reader :average_rating, :review_count, :url, :error

  def service_name
    "Amazon"
  end

  def service_logo
    "amazon-logo.png"
  end

  def book_exists?
    !@book.nil?
  end

  def search(isbn)
    begin
      @book = RakutenRapidAPI::AmazonPrice.search(isbn).first
    rescue
      return @error = true
    end

    if book_exists?
      @url = @book["detailPageURL"]
      @average_rating = @book["rating"]
      @review_count = @book["totalReviews"]
    end
  end
end
