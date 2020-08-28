# frozen_string_literal: true

class SearchController < ApplicationController
  def index
    @book = Book.new(params[:isbn])
    @book.fetch
  end
end
