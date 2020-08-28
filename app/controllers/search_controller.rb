# frozen_string_literal: true
class SearchController < ApplicationController
  def index
    return if params[:isbn].blank?

    @book = Book.new(params[:isbn])
    @book.fetch if @book.valid_isbn?
  end
end
