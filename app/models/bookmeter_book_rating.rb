# frozen_string_literal: true

require "open-uri"

class BookmeterBookRating
  include BookRatingable

  attr_reader :average_rating, :review_count, :url

  def service_name
    "読書メーター"
  end

  def book_exists?
    !@book_path.nil?
  end

  def search(isbn)
    @book_path = parse_book_path(isbn)

    if book_exists?
      @url = "https://bookmeter.com#{@book_path}"
      @doc = Nokogiri::HTML.parse(URI.open(@url))
      @average_rating = parse_average_rating
      @review_count = parse_review_count
    end
  end

  private
    def parse_book_path(isbn)
      search_url = "https://bookmeter.com/search?keyword=#{isbn}"

      response = Net::HTTP.get(URI.parse(search_url))
      hash = JSON.parse(response)

      if hash["resources"].empty?
        nil
      else
        hash["resources"][0]["contents"]["book"]["path"]
      end
    end

    def parse_average_rating
      if @doc.at_css(".supplement__value.average").nil?
        "評価なし"
      else
        (@doc.at_css(".supplement__value.average").text.to_i * 0.05).round(2)
      end
    end

    def parse_review_count
      if @doc.at_css(".supplement__value.count").nil?
        "0"
      else
        @doc.at_css(".supplement__value.count").text
      end
    end
end
