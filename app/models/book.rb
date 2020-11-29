# frozen_string_literal: true

class Book
  attr_reader :author, :cover_image, :publisher,
              :release_date, :title, :isbn13

  def initialize(isbn)
    @isbn = isbn.delete("-")
  end

  def exists?
    !@book.empty?
  end

  def fetch
    @book = OpenBD::Client.new.search(isbns: [@isbn])

    @book.resources.each do |resource|
      @cover_image = resource.cover_image
      @publisher = resource.publisher
      @release_date = resource.release_date
      @title = resource.title
      @author = resource.author
      @isbn13 = resource.isbn
    end
  end

  def valid_isbn?
    if /^[0-9]{13}$/ =~ @isbn || /^[0-9]{9}[[0-9]|x|X]$/ =~ @isbn
      true
    else
      false
    end
  end
end
