# frozen_string_literal: true

require "open-uri"

class BookmeterBookRating < BookRating
  attr_reader :average_rating, :review_count, :url, :error

  def service_name
    "読書メーター"
  end

  def service_logo
    "bookmeter-logo.png"
  end

  def book_exists?
    !@book_path.nil?
  end

  def search(isbn)
    @book_path = extract_book_path(isbn)

    if book_exists?
      @url = "https://bookmeter.com#{@book_path}"
      begin
        @doc = Nokogiri::HTML.parse(URI.open(@url, open_timeout: 15, read_timeout: 15))
      rescue
        @doc = nil
      end
      @average_rating = extract_average_rating
      @review_count = extract_review_count
    end
  end

  private
    def extract_book_path(isbn)
      search_url = "https://bookmeter.com/search?keyword=#{isbn}"
      url = URI(search_url)
      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      http.open_timeout = 15
      http.read_timeout = 15
      http.write_timeout = 15
      request = Net::HTTP::Get.new(url)

      begin
        response = http.request(request)
      rescue
        @error = true
        return nil
      end

      hash = JSON.parse(response.read_body)
      if hash["resources"].empty?
        nil
      else
        hash["resources"][0]["contents"]["book"]["path"]
      end
    end

    def extract_average_rating
      if @doc.nil?
        "取得エラー"
      else
        if @doc.at_css(".supplement__value.average").nil?
          "評価なし"
        else
          (@doc.at_css(".supplement__value.average").text.to_i * 0.05).round(2)
        end
      end
    end

    def extract_review_count
      if @doc.nil?
        "取得エラー"
      else
        if @doc.at_css(".supplement__value.count").nil?
          "0"
        else
          @doc.at_css(".supplement__value.count").text
        end
      end
    end
end
