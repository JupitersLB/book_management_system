Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  scope :v1 do
    resources :users, only: %i[show create]

    resources :books, only: %i[index show] do
      member do
        get 'search'
      end
    end

    resources :borrowed_books, only: %i[index create] do
      collection do
        patch 'return_book'
        get 'status'
      end
    end
  end
end
