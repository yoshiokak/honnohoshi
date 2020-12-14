# frozen_string_literal: true

module RakutenRapidAPI
  class AmazonPrice
    def self.search(isbn)
      url = URI("https://amazon-price1.p.rapidapi.com/search?keywords=#{isbn}&marketplace=JP")

      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      http.open_timeout = 15
      http.read_timeout = 15
      http.write_timeout = 15

      request = Net::HTTP::Get.new(url)
      request["x-rapidapi-host"] = "amazon-price1.p.rapidapi.com"
      request["x-rapidapi-key"] = ENV["X_RAPIDAPI_KEY"]

      response = http.request(request)
      JSON.parse(response.read_body)
    end
  end
end
