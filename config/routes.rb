Rails.application.routes.draw do
  root 'menus#index'

  devise_for :users, controllers: {
      registrations: 'registrations',
      omniauth_callbacks: 'omniauth_callbacks'
  }
  devise_scope :user do
    patch 'registrations/change_password', to: 'registrations#change_password', as: :change_password_user_registration
  end
  resources :users
  get '/token', to: 'users#token', as: :token
  get '/clear_tokens', to: 'users#clear_tokens', as: :clear_tokens

  resources :menus
  get 'form_today', to: 'menus#form_today', as: :form_today_menu
  get 'menu_details', to: 'menus#menu_details', as: :menu_details
  get 'render_modal', to: 'menus#render_modal', as: :render_modal

  resources :items
  resources :meals

  resources :orders
  get 'order_details', to: 'orders#order_details', as: :order_details
  get 'refresh_orders', to: 'orders#refresh_orders', as: :refresh_orders

  namespace :api do
    namespace :v1 do
      resources :orders, only: :index
    end
  end
end
