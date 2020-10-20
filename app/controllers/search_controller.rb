# frozen_string_literal: true

class SearchController < ApplicationController
  def index
    return if params[:isbn].blank?

    @book = Book.new(params[:isbn])
    @book.fetch_open_bd if @book.valid_isbn? && @book.exists_in_open_bd?
  end

  def book_reviews
    @services = Service.search(params[:isbn13])
    render partial: "book_reviews"
  end
end
