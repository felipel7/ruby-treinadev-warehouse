Rails.application.routes.draw do
  devise_for :users

  authenticate :user do
    root to: "home#index"

    resources :warehouses, only: [:show, :new, :create, :edit, :update, :destroy] do
      resources :stock_product_destinations, only: [:create]
    end
    resources :suppliers, only: [:index, :show, :new, :create, :edit, :update]
    resources :product_models, only: [:index, :show, :new, :create]
    resources :product_models, only: [:index, :show, :new, :create]
    resources :orders, only: [:show, :new, :create, :index, :edit, :update] do
      get "search", on: :collection
      post "delivered", on: :member
      post "canceled", on: :member
      resources :order_items, only: [:new, :create]
    end
  end

  namespace :api do
    namespace :v1 do
      resources :warehouses, only: [:show]
    end
  end
end
