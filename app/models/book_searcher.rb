# frozen_string_literal: true

class BookSearcher
  def self.search(isbn)
    book = OpenBD::BookSearcher.search(isbn)

    if book.nil?
      book = RakutenBooks::BookSearcher.search(isbn)
    else
      if book.cover_image.blank?
        search_result = RakutenWebService::Books::Book.search(isbn: isbn.delete("-")).first
        book.cover_image = search_result.large_image_url unless search_result.nil?
      end
    end

    book
  end
end
