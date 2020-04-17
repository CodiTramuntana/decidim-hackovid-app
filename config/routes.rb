# frozen_string_literal: true

Rails.application.routes.draw do
  mount Decidim::Core::Engine => '/'
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :solutions, only: [:index, :new, :create, :edit, :update, :destroy] do
    collection do
      get :export
    end
  end
  get :winners, to: 'winners#show'
end
