# frozen_string_literal: true

class BookReviewsController < ApplicationController
  def index
    @services = BulkSearcher.search(params[:isbn13])
  end
end
