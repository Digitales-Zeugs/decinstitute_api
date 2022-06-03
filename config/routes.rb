Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      get 'shopify/index'
      post 'shopify/get_order_info', to: 'shopify#get_order_info'
      get 'shopify/generate_rd_string'
    end
  end
  
end
