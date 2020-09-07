# frozen_string_literal: true

class SearchController < ApplicationController
  def index
    return if params[:isbn].blank?

    @book = Book.new(params[:isbn])
    if @book.valid_isbn?
      @book.fetch
      @services = Service.search(@book.isbn13)
    end
  end
end
