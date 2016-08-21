Rails.application.routes.draw do

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root 'pages#home'

  devise_for :users,
       :path => '' ,
       :path_names => {:sign_in => 'login', :sign_out => 'logout', :edit => 'profile'},
       :controllers => {:omniauth_callbacks => 'omniauth_callbacks',
                :registrations => 'registrations'
              }


 resources :users, only: [:index, :show] do

 end
 resources :revisers
  get '/premium/', to: 'revisers#show'
 resources :photos
 resources :pages

 #make sure to change this to user!!! instead of reservations!!!
resources :reviser do
  resources :reservations, only: [:create, :edit, :update]
end


get '/preload' => 'reservations#preload'
get '/preview' => 'reservations#preview'

get '/your_reservations' => 'reservations#your_reservations'

post '/notify' => 'reservations#notify'
get '/mypayments' => 'reservations#your_essays'
# get '/your_essays' => 'reservations#your_essays'



get '/school_list' => 'pages#school_list'
get '/about' => 'pages#about'

get '/mentor' => 'pages#mentor'
# get '/payment' => 'pages#payment'
# get '/revisers/11', to: 'patients#show', as: 'payment'

get '/how-to-use/kr' => 'pages#korea'
get '/how-to-use/en' => 'pages#english'
get '/how-to-use/jp' => 'pages#japan'
get '/how-to-use/ch' => 'pages#china'





resources :revisers do
  resources :reviews, only: [:create, :destroy]
end


 resources :suggestions do
  get :autocomplete_user_country, :on => :collection
  get :autocomplete_user_company_name, :on => :collection

  get :autocomplete_user_city, :on => :collection
  get :autocomplete_user_school, :on => :collection
  get :autocomplete_user_major, :on => :collection
 end



 # Community
 resources :boards do
   resources :posts do
       resources :comments
   end
 end
 resources :posts do
     resources :comments
   end

# Messages

 resources :conversations, only: [:index, :show, :destroy] do
   member do
     post :reply
   end
 end
 resources :conversations, only: [:index, :show, :destroy] do
   member do
     post :restore
   end
 end
 resources :conversations, only: [:index, :show, :destroy] do
     collection do
       delete :empty_trash
     end
   end

 resources :conversations, only: [:index, :show, :destroy] do
   member do
     post :mark_as_read
   end
 end
 resources :messages, only: [:new, :create]



 resources :posts do
  resources :comments
  resources :places
end



end
