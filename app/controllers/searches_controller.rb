# frozen_string_literal: true

class SearchesController < ApplicationController
  def show
    return if params[:isbn].blank?

    @book = Book.new(params[:isbn])
    @book.fetch_open_bd if @book.valid_isbn? && @book.exists_in_open_bd?
  end
end
