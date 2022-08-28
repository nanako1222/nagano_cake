Rails.application.routes.draw do
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}

  devise_for :customers,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

get '/' => 'public/homes#top'
get '/about' => 'public/homes#about'

  namespace :admin do
    get 'order_details/update'
    resources :orders, only: [:update, :show, :index]
    resources :customers, only: [:update, :show, :index, :edit]
    resources :genres, only: [:update, :create, :index, :edit]
    resources :items, only: [:update, :create, :index, :edit, :new, :show]
    get '/' => 'homes#top'
    resources :sessions, only: [:destroy, :create, :new]
  end

  namespace :public do
    resources :addresses, only: [:destroy, :update, :index, :edit, :create]
    resources :orders, only: [:new, :confirm, :index, :thanks, :create, :show]
    resources :cart_items, only: [:destroy, :update, :index, :destroy_all, :create]
    resource :customers, only: [:out, :confirm, :update, :edit, :show]
    resources :sessions, only: [:destroy, :new, :create]
    resources :registrations, only: [:new, :create]
    resources :items, only: [:index, :show]
    resources :homes, only: [:top, :about]
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
