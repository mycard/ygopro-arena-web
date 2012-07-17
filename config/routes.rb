MycardServerHttp::Application.routes.draw do
  get "stream/index"

  resources :referees

  resources :enrolls

  resources :matches

  resources :tournaments

  get "captcha/show"

  resources :attachments

  resources :moderators

  resources :servers

  resources :libraries

  resources :decks

  get "rooms/index"

  get "mycard/update"
  get "mycard/download"

  root :to => "mycard#index"
  
  resources :duels do
    get 'user1_deck.:format' => "duels#user1_deck"
    get 'user2_deck.:format' => "duels#user2_deck"
  end
  resources :cards
  get 'search/cards' => 'cards#search'
  resources :users do
    resources :duels
    resources :cards
  end
  resources :boards
  resources :topics
  resources :rooms
  get 'topics/control' => "topics#control", :as => :control_topics
  resources :posts
  resources :users do
    get 'pms' => "pms#index"
    get 'topics' => "users#topic"
  end
  get 'theme/:theme' => 'users#theme', :as => :theme
  match 'login' => 'users#login'
  get 'logout' => 'users#logout'
  get 'register' => 'users#new'
  resources :pms
  resources :links
  resources :moderations
  resources :stream
  match "/captcha" => "captcha#show"
  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
