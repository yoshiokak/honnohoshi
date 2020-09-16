# frozen_string_literal: true

class SearchController < ApplicationController
  def index
    return if params[:isbn].blank?
    @book = Book.new(params[:isbn])
    if @book.valid_isbn?
      @book.fetch
    end
  end

  def book_reviews
    @services = Service.search(params[:isbn13])
    render partial: "book_reviews"
  end
end
