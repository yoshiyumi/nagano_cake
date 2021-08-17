Rails.application.routes.draw do

  devise_for :admins, controllers: {
    sessions:      'admin/admins/sessions',
    passwords:     'admin/admins/passwords',
    registrations: 'admin/admins/registrations'
  }

  namespace :admin do

   get "/" => "homes#top"
   resources :customers,only: [:index,:show,:edit,:update]
   resources :genres,only: [:index,:create,:edit,:update]
   resources :items, except: [:destroy]
   resources :orders,only: [:show,:update]
   resources :order_details,only: [:update]
 end


 devise_for :customers, controllers: {
   sessions:      'public/customers/sessions',
   passwords:     'public/customers/passwords',
   registrations: 'public/customers/registrations'
 }

 root to: "public/homes#top"
 get "/about" => "public/homes#about"

  scope module: :public do
   get "/customers/my_page" => "customers#show"
   get '/customers/confirm' => 'customers#confirm'
   patch '/customers/withdraw' => 'customers#withdraw'
   resources :customers,only: [:show,:edit,:update]
   delete '/cart_items/destroy_all' => 'cart_items#destroy_all'
   resources :cart_items,only: [:index,:create,:update,:destroy]
   resources :items, only: [:index,:show]
   resources :orders,only: [:new,:index,:show,:create] do
    collection do
     get :thanks
     post :confirm
    end
   end

   resources :addresses,except: [:show,:new]
 end




  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
