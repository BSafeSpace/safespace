Rails.application.routes.draw do
  
  resources :resources do
    post 'sort', on: :collection
  end
  resources :quizzes
  resources :friendships
  resources :characteristics
  # match '/contacts', to: 'contacts#new', via: 'get'
  resources "contacts", only: [:new, :create]
  
  resources :profiles do
    collection do 
      get 'default_search'
      get 'peer_counselors'
      match 'search' => 'profiles#search', via: [:get, :post], as: :search
    end
    member do
      put 'showcase_reset'
    end
  end

  resources :contents
  resources :terms_of_services

  # devise_for :users, :controllers => {:destroy => "destroy"}
  devise_for :users, controllers: { destroy: "destroy", registrations: "registrations" }
  root 'static_pages#home'
  get 'about' => 'static_pages#about', :as => :home_about
  get 'contact' => 'static_pages#contact', :as => :contact
  get 'info' => 'intro#info', :as => :intro_info
  get 'quiz' => 'intro#quiz', :as => :intro_quiz
  get 'terms_of_service' => 'intro#liability', :as => :intro_terms_of_service
  get 'create_bio' => 'intro#create_bio', :as => :intro_create_bio
  put 'sign_liability' => 'intro#sign_liability', :as => :intro_sign_liability
  
  get '/toggle_appear_offline', to: 'application#toggle_appear_offline', as: :toggle_appear_offline
  
  resources :recommendations do
    get 'resolve', on: :member
  end

  resources :conversations do
    member do
      get 'download_chat'
      post 'mute'
      delete 'mute'
      post 'recommend_to_peer_counselor'
      get 'read_messages'
    end

    collection do
      get 'update_convo_id'
      post 'create_peer_chat'
    end

    resources :messages do
      collection do
        post 'create_peer_message'
        get 'get_message_time'
      end
    end
  end

  # get 'conversations/download_chat'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

end
