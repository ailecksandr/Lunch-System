Rails.application.routes.draw do
  root 'menus#index'

  devise_for :users, controllers: { registrations: 'registrations' }
  devise_scope :user do
    patch 'registrations/change_password', to: 'registrations#change_password', as: :change_password_user_registration
  end

  resources :users
  resources :items
  resources :menus
  get 'form_today', to: 'menus#form_today', as: :form_today_menu
  get 'menu_details', to: 'menus#menu_details', as: :menu_details
  resources :meals
  resources :orders
  get 'order_details', to: 'orders#order_details', as: :order_details
  get 'refresh_orders', to: 'orders#refresh_orders', as: :refresh_orders
end
