Rails.application.routes.draw do

  resources :courses

  resources :schools do
    resources :students
    resources :rooms
    resources :class_sessions
    resources :periods
  end

  root :to => 'home#index'

  #-----HOME NAVIGATION
  get '/', to: 'home#index', as: 'home'
  get 'contact', to: 'home#contact', as: 'contact'


  #-----DELETION PAGES
  get '/schools/:id/delete', to: 'schools#delete', as: 'delete_school'
  get '/schools/:school_id/rooms/:id/delete', to: 'rooms#delete', as: 'delete_school_room'
  get '/schools/:school_id/students/:id/delete', to: 'students#delete', as: 'delete_school_student'
  get '/schools/:school_id/class_sessions/:id/delete', to: 'class_sessions#delete', as: 'delete_school_class_session'
  get '/schools/:school_id/periods/:id/delete', to: 'periods#delete', as: 'delete_school_period'


  #-----TEACHER AND SESSION NAVIGATION
  resources :teachers
  resources :sessions

  get '/dashboard', to: 'teachers#dashboard', as: 'dashboard'
  get '/login', to: 'sessions#new', as: 'login'
  get '/logout', to: 'sessions#destroy', as: 'logout'


  #-----SPECIAL PATHS
  get '/schools/:school_id/rooms/:room_id/new_class_session', to: 'class_sessions#new', as: 'new_school_room_class_session'





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
