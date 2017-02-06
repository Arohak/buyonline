Rails.application.routes.draw do

  # post 'verifications' => 'verifications#create'
  # put 'verifications' => 'verifications#verify'

  namespace :get do
    get '/categories',    to: 'parsecategories#parse'

    get '/subcategories', to: 'parsesubcategories#parse'

    get '/menu',        to: 'parsemenu#parse'
    get '/menu_tr',     to: 'parsemenu#translation'

    get '/product',     to: 'parseproduct#parse'
    get '/product_tr',  to: 'parseproduct#translation'

    get '/delivery',    to: 'parsedelivery#parse'

    get '/address',     to: 'parseaddress#parse'
  end

  namespace :api do
    namespace :v1 do

      post '/send_phone',  to: 'users#send_phone'
      post '/verify',   to: 'users#verify'

      resources :orders, only: [:index, :update, :create]

      resources :favorites, only: [:index, :update]

      resources :users

      resources :deliveryaddresses

      resources :categories, only: [:index, :show] do
        resources :subcategories, only: [:index, :show]
      end

      resources :restaurants do
        resources :categoryitems, only: [:index, :show]
      end

      resources :categoryitems do
        resources :products, only: [:index, :show]
      end

      resources :products, only: [:index, :show]

      resources :deliveries, only: [:index, :show]

      get '/home', to: 'objects#home'
      get '/newobjects', to: 'objects#news'
      get '/rateobjects', to: 'objects#rate'
      get '/openobjects', to: 'objects#open'

      get '/nears_objects', to: 'restaurants#nearst'

    end
  end

end
