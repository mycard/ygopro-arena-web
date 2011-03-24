Reliz::Application.routes.draw do
  resources :moderations

  resources :boards

  root :to => 'boards#index'
  
  resources :users

  resources :blocks

  resources :boards
  match 'forum' => 'boards#index'
  match 'forum/:id/(/:page)' => 'boards#show', :id => /\d+/, :page => /\d+/ 
  
  resources :posts
  match 'forum/:topic_id/new' => 'posts#new', :topic_id => /\d+/ #����ظ�
  
  resources :topics
  match 'topic/:id/(/:page)' => 'topics#show', :id => /\d+/, :page => /\d+/ 
  match 'forum/:forum_id/new' => 'topics#new', :forum_id => /\d+/ #
  get 'topic/control' => 'topics#control'
  
  match ':something/:anything', :controller => 'application', :action => 'redirect_to_thc', :something => /forum|boards|topic|topics|posts/, :anything => /.*/
  match '/:anything', :controller => 'application', :action => 'redirect_to_thc', :anything => /.*/
  
  
  
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
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end