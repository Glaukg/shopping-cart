Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  resources :carts, only: [:create, :index, :update, :destroy, :show]
  resources :products, only: [:create, :index, :update, :destroy, :show]

  post 'carts/add_product_to_cart', to: 'carts#add_product_to_cart'
  get '/get_cart_by_email', to: 'carts#get_cart_by_email'
  delete '/delete_product_from_cart', to: 'carts#delete_product_from_cart'
  get '/export_cart_csv', to: 'carts#export_cart_csv'
  get '/export_product_csv', to: 'products#export_product_csv'
  get '/export_cart_by_email_csv', to: 'carts#export_cart_by_email_csv'
end
