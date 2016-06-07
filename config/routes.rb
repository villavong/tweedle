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



resources :conversations, only: [:index, :create] do
   resources :messages, only: [:index, :create]
 end


 resources :posts do
  resources :comments
  resources :places
end



end
