# frozen_string_literal: true

require "open-uri"

class Hongasuki
  include Serviceable

  attr_reader :average_rating, :review_count, :url

  def name
    "本が好き！"
  end

  def book_exists?
    !@book_path.nil?
  end

  def search(isbn)
    @book_path = parse_book_path(isbn)

    if book_exists?
      @url = "https://www.honzuki.jp#{@book_path}"
      @doc = Nokogiri::HTML.parse(URI.open(@url, ssl_verify_mode: OpenSSL::SSL::VERIFY_NONE))
      @average_rating = parse_average_rating
      @review_count = parse_review_count
    end
  end

  private
    def parse_book_path(isbn)
      search_url = "https://www.honzuki.jp/book/book_search/index.html?search_in=honzuki&isbn=#{isbn}"

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
end
