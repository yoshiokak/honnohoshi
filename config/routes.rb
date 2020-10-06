# frozen_string_literal: true

Rails.application.routes.draw do
  get 'help/index'
  root to: "home#index"
  get "/search", to: "search#index"
  get :book_reviews, controller: :search
end
