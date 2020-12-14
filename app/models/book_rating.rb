# frozen_string_literal: true

class BookRating
  def service_name
    raise NotImplementedError
  end

  def service_logo
    raise NotImplementedError
  end

  def book_exists?
    raise NotImplementedError
  end

  def search
    raise NotImplementedError
  end

  def average_rating
    raise NotImplementedError
  end

  def review_count
    raise NotImplementedError
  end

  def url
    raise NotImplementedError
  end

  def error
    raise NotImplementedError
  end
end
