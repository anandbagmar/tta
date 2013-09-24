Tta::Application.routes.draw do

  get '/home' => "home#index"

  get '/upload' => "upload#new"
  get '/upload/show'
  post '/upload/create'
  post '/upload/automatic' => "upload#automatic"

  get '/pyramid' => "visualization#pyramid"
  post '/pyramid/result' => "visualization#sub_project_filter"

  get '/defect_analysis' => "defect_analysis#new"
  post '/defect_analysis/result' => "defect_analysis#sub_project_filter"

  get '/comparative_analysis' => "comparative_analysis#create"
  post '/comparative_analysis/result' => "comparative_analysis#date_filter"

  get '/execution_trends' => "execution_trends#new"
  post '/execution_trends/result' => "execution_trends#show"

  get '/admin/' => 'admin#default'
  post '/admin/add' => "admin#add"

  get '/stats' => 'admin#view'

  get '/get_run_dates' => 'defect_analysis#getRunDates'
  get '/get_specific_run' => 'defect_analysis#getSpecificRun'

  get '/compare_runs/' => 'compare_runs#index'
  get '/get_sub_project_data' => 'compare_runs#getSubProjects'
  get '/get_test_types' => 'compare_runs#getTestTypes'
  get '/get_compare_json' => 'compare_runs#getCompareJson'
  get '/get_compare_dates' => 'compare_runs#getDateRuns'
  get '/get_class_names' => 'execution_trends#class_names'


  get '*path' => 'application#handle404'

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
  root :to => 'home#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
