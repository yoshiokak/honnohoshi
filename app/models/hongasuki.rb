# frozen_string_literal: true

require "open-uri"

class Hongasuki
  attr_reader :average_rating, :review_count, :url

  def initialize(isbn)
    @isbn = isbn
  end

  def fetch
    @book = parse_book_path

    if book_exists?
      @url = parse_url
      @doc = Nokogiri::HTML.parse(URI.open(@url, ssl_verify_mode: OpenSSL::SSL::VERIFY_NONE))
      @average_rating = parse_average_rating
      @review_count = parse_review_count
    end
  end

  def name
    "本が好き！"
  end

  def book_exists?
    if @book.nil?
      false
    else
      true
    end
  end

  private
    def search_url
      "https://www.honzuki.jp/book/book_search/index.html?search_in=honzuki&isbn=#{@isbn}"
    end

    def parse_book_path
      doc = Nokogiri::HTML.parse(URI.open(search_url, ssl_verify_mode: OpenSSL::SSL::VERIFY_NONE))
      if doc.at_css("td > a").nil?
        nil
      else
        doc.at_css("td > a").attributes["href"].value
      end
    end

    def parse_average_rating
      if @doc.at_css("b[itemprop='average']").text == "0"
        "評価なし"
      else
        @doc.at_css("b[itemprop='average']").text
      end
    end

    def parse_review_count
      @doc.at_css("b[itemprop='votes']").text
    end

    def parse_url
      "https://www.honzuki.jp#{parse_book_path}"
    end
end
