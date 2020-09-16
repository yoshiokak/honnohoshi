# frozen_string_literal: true

Rails.application.routes.draw do
  root to: "search#index"
  get :book_reviews, controller: :search
end
