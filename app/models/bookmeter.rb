# frozen_string_literal: true

require "open-uri"

class Bookmeter
  def initialize(isbn)
    @isbn = isbn
  end

  def average_rating
    if doc.at_css(".supplement__value.average").nil?
      "評価なし"
    else
      (doc.at_css(".supplement__value.average").text.to_i * 0.05).round(2)
    end
  end

  def review_count
    if doc.at_css(".supplement__value.count").nil?
      "0"
    else
      doc.at_css(".supplement__value.count").text
    end
  end

  def name
    "読書メーター"
  end

  def url
    "https://bookmeter.com/#{parse_book_path}"
  end

  def book
    parse_book_path
  end

  private
    def doc
      Nokogiri::HTML.parse(URI.open(url))
    end

    def search_url
      "https://bookmeter.com/search?keyword=#{@isbn}"
    end

    def parse_book_path
      response = Net::HTTP.get(URI.parse(search_url))
      hash = JSON.parse(response)

      if hash["resources"].empty?
        nil
      else
        hash["resources"][0]["contents"]["book"]["path"]
      end
    end
end
