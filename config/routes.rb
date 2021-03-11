Rails.application.routes.draw do
  resources :houses do
    match '/scrape', to: 'houses#scrape', via: :post, on: :collection
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #
  root to: 'houses#index'
end
