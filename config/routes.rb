Rails.application.routes.draw do

 # mount Ckeditor::Engine => '/ckeditor'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'posts#index'
  get "posts/title-:title" => "posts#show_by_title", as: "post_by_title"
  resources :posts


  resources :users
  get '/signup' => "users#new", as: :signup
  get '/login' => "users#login", as: :login
  post '/login' => "users#authenticate"
  delete '/logout:id' => "users#logout", as: :logout
end
