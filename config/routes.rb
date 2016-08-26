Rails.application.routes.draw do
  devise_for :users, controllers: {
      registrations: 'registrations'
  }
  devise_scope :user do
    patch 'registrations/change_password', to: 'registrations#change_password', as: :change_password_user_registration
  end

  root 'home#index'
end
