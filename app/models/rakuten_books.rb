class RakutenBooks
  def initialize(isbn)
    @isbn = isbn
  end

  def average_rating
    book.review_average
  end

  def review_count
    book.review_count
  end

  def name
    "楽天ブックス"
  end

  def url
    book.affiliate_url
  end

  def book
    RakutenWebService::Books::Book.search(isbn: @isbn).first
  end
end
