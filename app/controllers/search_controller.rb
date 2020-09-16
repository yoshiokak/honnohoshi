# frozen_string_literal: true

class SearchController < ApplicationController
  def index
    return if params[:isbn].blank?

    @book = Book.new(params[:isbn])
    @book.fetch if @book.valid_isbn?
  end

  def book_reviews
    @services = Service.search(params[:isbn13])
    render partial: "book_reviews"
  end
end
