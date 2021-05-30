Rails.application.routes.draw do
  root 'pages#index'

  namespace :api do
    namespace :v1 do
      resources :metrics do
        resources :readings, only: %i[create destroy]
      end
    end
  end

  get '*path', to: 'pages#index', via: :all
end
