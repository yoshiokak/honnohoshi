# frozen_string_literal: true

class Book
  attr_reader :author, :cover_image, :publisher,
              :release_date, :title, :isbn13
  attr_writer :cover_image

  def initialize(author:, cover_image:, publisher:,
                 release_date:, title:, isbn13:)
    @author = author
    @cover_image = cover_image
    @publisher = publisher
    @release_date = release_date
    @title = title
    @isbn13 = isbn13
  end
end
