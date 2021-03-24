Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root "homepage#index"
    get "/login", to: "sessions#new"
    post "/login", to: "sessions#create"
    delete "/logout", to: "sessions#destroy"
    resource :users, except: :destroy do
      member do
        get :change_password
        patch :update_change_password
      end
    end
    resources :account_activations, only: :edit
    resources :password_resets, except: [:index, :show, :destroy]
    resources :jobs, only: [:show, :index]
    resources :institutions, only: :show do
      member do
        get :jobs
        get :users
      end
    end
  end
end
