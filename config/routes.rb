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
    resources :institutions, only: [:show, :update] do
      member do
        get :info, :jobs, :users
        patch :fire
      end
    end

    namespace :recruiter do
      resources :institutions, except: [:index, :show, :destroy]
      resources :jobs, except: [:show, :destroy] do
        member do
          patch :close
        end
      end
      resources :users, only: [:index, :show]
    end

    namespace :candidate do
      resources :curriculum_vitaes, except: [:index, :show, :destroy]
      resources :recruitments, only: [:create]
    end

    namespace :admin do
      resources :jobs, only: [:index, :update] do
        member do
          patch :open
        end
      end
      resources :users, only: :index do
        member do
          patch :active, :block
        end
      end
    end
  end
end
