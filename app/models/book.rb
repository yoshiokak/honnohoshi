# frozen_string_literal: true

class Book
  attr_reader :author, :cover_image, :publisher,
              :release_date, :title

  def initialize(isbn)
    @isbn = isbn
  end

  def exist?
    @exist
  end

  def fetch
    client = OpenBD::Client.new
    response = client.search(isbns: [@isbn])

    if response.empty?
      return @exist = false
    else
      @exist = true
    end

    response.resources.each do |resource|
      @cover_image = resource.cover_image
      @publisher = resource.publisher
      @release_date = resource.release_date
      @title = resource.title
      @author = resource.author
    end
  end
end
