Rails.application.routes.draw do

  root to: 'tests#index'

  get 'contact_us', to: "contact#contact_us"
  post 'send_form', to: "contact#send_form"

  devise_for :users, path: :gurus, path_names: {sign_in: :login, sign_out: :logout}

  resources :tests, only: :index do
    member do
      post :start
    end
  end

  # GET /test_passages/101/result
  resources :test_passages, only: %i[show update] do
    member do
      get :result
      post :gist
    end
  end

  namespace :admin do
    resources :tests do
      patch :update_inline, on: :member

      resources :questions, shallow: true, except: :index do
        resources :answers, shallow: true, except: :index
      end
    end
    resources :gists, only: :index
  end
end

