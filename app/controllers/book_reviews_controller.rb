# frozen_string_literal: true

class BookReviewsController < ApplicationController
  def index
    @services = Service.search(params[:isbn13])
  end
end
