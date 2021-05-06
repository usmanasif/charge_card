Rails.application.routes.draw do
  resources :stripe, controller: :stripe, only: [] do
    collection do
      post :webhook
    end
  end

  namespace :api do
    namespace :v1 do
      resources :cards, only: [:show, :index]
      resources :transaction_lists, only: [:show, :index]
      resources :transactions, only: [:index]
    end
  end
end
