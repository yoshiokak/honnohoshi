# frozen_string_literal: true

class SearchesController < ApplicationController
  def show
    return unless ISBN.valid?(params[:isbn])

    @isbn = ISBN.thirteen(params[:isbn])
    @book = BookSearcher.search(@isbn)
  end
end
