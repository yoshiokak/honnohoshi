# frozen_string_literal: true

require "open-uri"

class Bookmeter
  attr_reader :average_rating, :review_count, :url

  def initialize(isbn)
    @isbn = isbn
  end

  def fetch
    @url = "https://bookmeter.com#{parse_book_path}"
    @doc = Nokogiri::HTML.parse(URI.open(@url))
    @average_rating = parse_average_rating
    @review_count = parse_review_count
  end

  def name
    "読書メーター"
  end

  def book_exists?
    !parse_book_path.nil?
  end

  private
    def parse_book_path
      search_url = "https://bookmeter.com/search?keyword=#{@isbn}"

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
