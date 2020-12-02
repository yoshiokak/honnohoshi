# frozen_string_literal: true

class BulkSearcher
  def self.search(isbn)
    book_ratings = []

    book_rating_target_list.each do |book_rating|
      book_ratings << Object.const_get(book_rating).new
    end

    Parallel.each(book_ratings, in_threads: book_ratings.size) do |book_rating|
      book_rating.search(isbn)
    end

    book_ratings
  end

  def self.book_rating_target_list
    [
      "AmazonBookRating",
      "RakutenBooksBookRating",
      "BookmeterBookRating",
      "HongasukiBookRating"
    ]
  end

  private_class_method :book_rating_target_list
end
