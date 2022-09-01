Rails.application.routes.draw do
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}

  devise_for :customers,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

root :to  => 'public/homes#top'
get '/about' => 'public/homes#about'

  namespace :admin do
    # get 'order_details/update'
    patch 'order_details/:id' => 'order_details#update', as: 'order_detail_update'
    resources :orders, only: [:update, :show, :index]
    resources :customers, only: [:update, :show, :index, :edit]
    resources :genres, only: [:update, :create, :index, :edit]
    resources :items, only: [:update, :create, :index, :edit, :new, :show]
    get '/' => 'homes#top'
    resources :sessions, only: [:destroy, :create, :new]
  end

  namespace :public do
    resources :addresses, only: [:destroy, :update, :index, :edit, :create]
    resources :orders, only: [:new, :index, :create, :show]
    get "/orders/confirm" => "orders#confirm"
    get "/orders/thanks" => "orders#thanks"
    resources :cart_items, only: [:destroy, :update, :index, :create]
    get "/cart_items/destroy_all" => "cart_items#destroy_all"
    resource :customers, only: [:out, :confirm, :update, :edit, :show]
     get "/customers/confirm" => "customers#confirm"
    resources :sessions, only: [:destroy, :new, :create]
    resources :registrations, only: [:new, :create]
    resources :items, only: [:index, :show]
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
