# frozen_string_literal: true

module RakutenBooks
  class BookSearcher
    def self.search(isbn)
      search_result = RakutenWebService::Books::Book.search(isbn: isbn.delete("-")).first

      if search_result.nil?
        book = nil
      else
        book = Book.new(author: search_result.author, cover_image: search_result.large_image_url,
                        publisher: search_result.publisher_name, release_date: search_result.sales_date,
                        title: search_result.title, isbn13: search_result.isbn)
      end

      book
    end
  end
end
