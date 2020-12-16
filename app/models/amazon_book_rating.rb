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
      @error = true
      return @book = nil
    end

    if book_exists?
      @url = @book["detailPageURL"]
      @average_rating = @book["rating"] == "" ? "評価なし" : @book["rating"]
      @review_count = @book["totalReviews"] == "" ? "0" : @book["totalReviews"]
    end
  end
end
