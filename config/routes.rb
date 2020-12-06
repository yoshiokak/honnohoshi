# frozen_string_literal: true

Rails.application.routes.draw do
  root to: "home#index"

  get "/disclaimer", to: "disclaimer#index"

  resource :search, only: :show
  resources :book_ratings, only: :index
end
