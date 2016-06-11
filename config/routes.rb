Rails.application.routes.draw do

root 'pages#home'

  devise_for :users ,
       :path => '' ,
       :path_names => {:sign_in => 'login', :sign_out => 'logout', :edit => 'profile'},
       :controllers => {:omniauth_callbacks => 'omniauth_callbacks',
                :registrations => 'registrations'
              }


 resources :users, only: [:index, :show] do

 end
 resources :revisers
 resources :photos
 resources :pages

 #make sure to change this to user!!! instead of reservations!!!
resources :reviser do
  resources :reservations, only: [:create]
end


get '/preload' => 'reservations#preload'
get '/preview' => 'reservations#preview'

get '/your_essays' => 'reservations#your_essays'
get '/your_reservations' => 'reservations#your_reservations'

post '/notify' => 'reservations#notify'
post '/your_essays' => 'reservations#your_essays'





 resources :suggestions do
  get :autocomplete_user_country, :on => :collection
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
