# frozen_string_literal: true

class BookRatingsController < ApplicationController
  def index
    @book_ratings = BulkSearcher.search(params[:isbn13])
  end
end
