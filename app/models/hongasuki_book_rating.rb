# frozen_string_literal: true

require "open-uri"

class HongasukiBookRating < BookRating
  attr_reader :average_rating, :review_count, :url

  def service_name
    "本が好き！"
  end

  def service_logo
    "hongasuki-logo.png"
  end

  def book_exists?
    !@book_path.nil?
  end

  def search(isbn)
    @book_path = extract_book_path(isbn)

    if book_exists?
      @url = "https://www.honzuki.jp#{@book_path}"
      @doc = Nokogiri::HTML.parse(URI.open(@url, ssl_verify_mode: OpenSSL::SSL::VERIFY_NONE))
      @average_rating = extract_average_rating
      @review_count = extract_review_count
    end
  end

  private
    def extract_book_path(isbn)
      search_url = "https://www.honzuki.jp/book/book_search/index.html?search_in=honzuki&isbn=#{isbn}"

      doc = Nokogiri::HTML.parse(URI.open(search_url, ssl_verify_mode: OpenSSL::SSL::VERIFY_NONE))
      if doc.at_css("td > a").nil?
        nil
      else
        doc.at_css("td > a").attributes["href"].value
      end
    end

    def extract_average_rating
      if @doc.at_css("b[itemprop='average']").text == "0"
        "評価なし"
      else
        @doc.at_css("b[itemprop='average']").text
      end
    end

    def extract_review_count
      @doc.at_css("b[itemprop='votes']").text
    end
end
