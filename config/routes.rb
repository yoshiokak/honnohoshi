# frozen_string_literal: true

Rails.application.routes.draw do
  get "home/index"
  root to: "search#index"
  get :book_reviews, controller: :search
end
