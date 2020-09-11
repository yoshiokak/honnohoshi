# frozen_string_literal: true

require "open-uri"

class Hongasuki
  def initialize(isbn)
    @isbn = isbn
  end

  def average_rating
    if doc.at_css("b[itemprop='average']").text == "0"
      "評価なし"
    else
      doc.at_css("b[itemprop='average']").text
    end
  end

  def review_count
    doc.at_css("b[itemprop='votes']").text
  end

  def name
    "本が好き！"
  end

  def url
    "https://www.honzuki.jp#{parse_book_path}"
  end

  def book
    parse_book_path
  end

  private
    def doc
      Nokogiri::HTML.parse(URI.open(url, :ssl_verify_mode => OpenSSL::SSL::VERIFY_NONE))
    end

    def search_url
      "https://www.honzuki.jp/book/book_search/index.html?search_in=honzuki&isbn=#{@isbn}"
    end

    def parse_book_path
      doc = Nokogiri::HTML.parse(URI.open(search_url, :ssl_verify_mode => OpenSSL::SSL::VERIFY_NONE))
      if doc.at_css("td > a").nil?
        nil
      else
        doc.at_css("td > a").attributes["href"].value
      end
    end
end
