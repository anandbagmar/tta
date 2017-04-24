Tta::Application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  root 'home#index'

  get '/home' => "home#index"

  get '/upload' => "upload#new"
  get '/upload/show'
  post '/upload/create'
  post '/upload/automatic' => "upload#automatic"
  get '/get_test_sub_category' => "upload#get_test_sub_category"
  get '/get_default_test_sub_category' => "upload#get_default_test_sub_category"

  get '/pyramid' => "visualization#pyramid"
  post '/pyramid/result' => "visualization#sub_project_filter"

  get '/defect_analysis' => "defect_analysis#new"
  post '/defect_analysis/result' => "defect_analysis#sub_project_filter"

  get '/comparative_analysis' => "comparative_analysis#create"
  get '/test_category_mapping_list' => "comparative_analysis#test_category_mapping_list"
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
  get '/get_compare_dates' => 'compare_runs#getDateRuns'
  post '/get_compare_json' => 'compare_runs#getCompareJson'

  get '/get_class_names' => 'execution_trends#class_names'

  get '*path' => 'application#handle404'


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
