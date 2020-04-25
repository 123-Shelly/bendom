Rails.application.routes.draw do

  resources :categories
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  resources :items do
    member do
      post :add_to_cart
    end

    resources :comments, only: [:create]
    # 做一條留言的連結
  end
  # resources :comments 沒必要全做，做上面create就好。
  # resources :items 自動做八條路徑
  # post "/abc/:id", to: "cart#add", as: :cc

    resource :cart, only: [:show, :destroy]

  get "/item", to: "items#index"
  post "/item", to: "items#creat"



  # welcome
  get "/index", to: "welcome#index" #welcome_index_path
  root "items#index" #root_path
  get "/login", to:"welcome#login"
  post "/login", to:"welcome#sign_in"
  get "/sign_up", to:"welcome#sign_up"
  post "/sign_up", to:"welcome#registration"
  delete "/logout", to:"welcome#logout"
  
  # cart沒寫完
  post "/abc/:id", to:"cart#add", as: :cc 
   # as: :cc 網址會加個path

   resource :cart, only:  [:create]
   # 單數，因為只有一台購物車

   # POST ""

  # item

  # apis
  namespace :api do
    namespace :v1 do
      resources :items, only: [] do
        member do 
         post :favorite
        end
      end
    end
  end

  
			
end
