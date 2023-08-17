# frozen_string_literal: true

Rails.application.routes.draw do
  resources :employees

  resources :projects do
    resources :tasks
  end

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  get 'logout', to: 'sessions#destroy'

  root 'employees#index'
end
