Rails.application.routes.draw do
  
  resources :buy_requests
  root 'pages#home'
  
  get 'test_page', to: 'pages#test_page'
  
  #resources :users
  
  get 'login', to: 'sessions#new', as: :login
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy', as: :logout
  get 'set_current_session/:id', to:'sessions#set_current_season', as: :set_current_season
  
  get 'players', to: 'players#index', as: :players
  get 'player/new', to: 'players#new', as: :new_player
  post 'player/new', to: 'players#create'
  get 'player/:id/edit', to: 'players#edit', as: :edit_player
  post 'player/:id/edit', to: 'players#update'
  get 'player/:id/change-password', to: 'players#initiate_change_password', as: :player_change_password
  post 'player/:id/change-password', to: 'players#handle_change_password'
  delete 'player/:id/delete', to: 'players#destroy', as: :delete_player
  
  get 'profile' => 'profiles#show', as: :profile
  get 'profile/change_password' => 'profiles#change_password', as: :change_password
  post 'profile/change_password' => 'profiles#update_password'
  
  get 'sports', to: 'sports#index', as: :sports
  get 'sport/new', to: 'sports#new', as: :new_sport
  post 'sport/new', to: 'sports#create'
  get 'sport/:id', to: 'sports#show', as: :show_sport
  get 'sport/:id/edit', to: 'sports#edit', as: :edit_sport
  post 'sport/:id/edit', to: 'sports#update'
  delete 'sport/:id/delete', to: 'sports#destroy', as: :delete_sport
  get 'sport/:sport_id/addLeague', to: 'leagues#new', as: :add_league
  post 'sport/:sport_id/addLeague', to: 'leagues#create'
  
  get 'leagues/:sport_id', to: 'leagues#index', as: :leagues
  #get 'league/new', to: 'leagues#new', as: :new_league
  #post 'league/new', to: 'leagues#create'
  get 'league/:id', to: 'leagues#show', as: :show_league
  get 'league/:id/edit', to: 'leagues#edit', as: :edit_league
  post 'league/:id/edit', to: 'leagues#update'
  delete 'league/:id/delete', to: 'leagues#destroy', as: :delete_league
  get 'league/:league_id/addSeason', to: 'seasons#new', as: :add_season
  post 'league/:league_id/addSeason', to: 'seasons#create'
  
  get 'seasons/:sport_id', to: 'seasons#index', as: :seasons
  get 'season/:id', to: 'seasons#show', as: :show_season
  get 'season/:id/edit', to: 'seasons#edit', as: :edit_season
  post 'season/:id/edit', to: 'seasons#update'
  get 'season/:id/manage', to: 'seasons#initiate_manage', as: :manage_season
  post 'season/:id/manage', to: 'seasons#handle_manage'
  delete 'season/:id/delete', to: 'seasons#destroy', as: :delete_season
  get 'season/:season_id/addTeam', to: 'teams#new', as: :add_team
  post 'season/:season_id/addTeam', to: 'teams#create'
  get 'season/:id/players', to: 'seasons#portfolio_index', as: :season_portfolio_index
  get 'season/:season_id/player/:portfolio_id', to: 'seasons#portfolio_view', as: :season_portfolio_view
  get 'season/:season_id/player/:portfolio_id', to: 'seasons#initiate_add_holding', as: :initiate_add_holding
  post 'season/:season_id/player/:portfolio_id', to: 'seasons#handle_add_holding'
  get 'season/:season_id/holding/:holding_id', to: 'seasons#edit_holding', as: :season_edit_holding
  post 'season/:season_id/holding/:holding_id', to: 'seasons#update_holding'
  delete 'season/:season_id/holding/:holding_id', to: 'seasons#delete_holding', as: :season_delete_holding
  
  get 'join-season', to: 'seasons#join_index', as: :join_index
  post 'season/:id/join', to: 'seasons#join', as: :join_season
  
  get 'teams/:season_id', to: 'teams#index', as: :teams
  get 'team/:id', to: 'teams#show', as: :show_team
  get 'team/:id/edit', to: 'teams#edit', as: :edit_team
  post 'team/:id/edit', to: 'teams#update'
  delete 'team/:id/delete', to: 'teams#destroy', as: :delete_team
  
  get 'portfolio', to: 'portfolios#show', as: :show_portfolio
  
  get 'sell/:holding_id', to: 'sell_requests#new', as: :sell_holding
  post 'sell/:holding_id', to: 'sell_requests#create'
  delete 'sell_request/:id/delete', to: 'sell_requests#destroy', as: :delete_sell_request
  get 'season/:id/buy', to: 'seasons#sell_request_index', as: :season_sell_requests
  get 'team/:id/buy', to: 'teams#sell_request_index', as: :team_sell_requests
  get 'sell_request/:id/buy', to: 'sell_requests#initiate_buy', as: :buy_sell_request
  post 'sell_request/:id/buy', to: 'sell_requests#process_buy'
  
  get 'buy/:team_id', to: 'buy_requests#new', as: :buy_team
  post 'buy/:team_id', to: 'buy_requests#create'
  delete 'buy_request/:id/delete', to: 'buy_requests#destroy', as: :delete_buy_request
  get 'season/:id/sell', to: 'seasons#buy_request_index', as: :season_buy_requests
  get 'team/:id/sell', to: 'teams#buy_request_index', as: :team_buy_requests
  get 'buy_request/:id/sell', to: 'buy_requests#initiate_sell', as: :sell_buy_request
  post 'buy_request/:id/sell', to: 'buy_requests#process_sell'
  
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
