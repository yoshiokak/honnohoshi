# frozen_string_literal: true

module OpenBD
  class BookSearcher
    def self.search(isbn)
      search_result = OpenBD::Client.new.search(isbns: [isbn.delete("-")])
      book = nil

      unless search_result.blank?
        search_result.resources.each do |resource|
          book = Book.new(author: resource.author, cover_image: resource.cover_image,
                          publisher: resource.publisher, release_date: resource.release_date,
                          title: resource.title, isbn13: resource.isbn)
        end
      end

      book
    end
  end
end
