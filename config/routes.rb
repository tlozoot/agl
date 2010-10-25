ActionController::Routing::Routes.draw do |map|
  
  map.root :controller => :experiments, :action => :new
  
  map.login 'login', :controller => 'user_sessions', :action => 'new'  
  map.logout 'logout', :controller => 'user_sessions', :action => 'destroy'
  
  map.resources :experiments do |experiments|
    experiments.training 'training', :controller => 'experiments', :action => 'training'
    experiments.trainingtest 'training_test', :controller => 'experiments', :action => 'training_test'
    experiments.learning 'learning', :controller => 'experiments', :action => 'learning'
    experiments.testing 'testing', :controller => 'experiments', :action => 'testing'
    experiments.finished 'finished', :controller => 'experiments', :action => 'finished'
    experiments.spelling 'spelling', :controller => 'experiments', :action => 'spelling'
  end
  
  map.resource :variable, :only => :show, :controller => :variable
  map.resource :fixed, :only => :show, :controller => :fixed
  map.resource :hebrew, :only => :show, :controller => :hebrew
  map.resources :hebrew, :controller => :experiments
  
  
  map.resources :results, :only => [:index, :show]
  map.resources :paradigms
  map.resources :participants, :only => [:update, :show]
  
  map.resources :user_sessions
  map.resources :users
  
  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  # map.root :controller => "welcome"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing or commenting them out if you're using named routes and resources.
  # map.connect ':controller/:action/:id'
  # map.connect ':controller/:action/:id.:format'
end
