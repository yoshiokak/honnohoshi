# frozen_string_literal: true

class BookRatingsController < ApplicationController
  def index
    @services = BulkSearcher.search(params[:isbn13])
  end
end
