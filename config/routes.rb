Rails.application.routes.draw do
  devise_for :users

  authenticate :user do
    root to: "home#index"

    resources :warehouses, only: [:show, :new, :create, :edit, :update, :destroy]
    resources :suppliers, only: [:index, :show, :new, :create, :edit, :update]
    resources :product_models, only: [:index, :show, :new, :create]
    resources :product_models, only: [:index, :show, :new, :create]
    resources :orders, only: [:show, :new, :create, :index, :edit, :update] do
      get "search", on: :collection
      post "delivered", on: :member
      post "canceled", on: :member
    end
  end
end
