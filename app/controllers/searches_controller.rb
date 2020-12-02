# frozen_string_literal: true

class SearchesController < ApplicationController
  def show
    return unless ISBN.valid?(params[:isbn])

    @isbn = params[:isbn]
    @book = Book.new.search(@isbn)
  end
end
