# frozen_string_literal: true

class SearchesController < ApplicationController
  def show
    return if params[:isbn].blank?

    @book = Book.new(params[:isbn])
    @book.fetch if @book.valid_isbn? && @book.exists?
  end
end
