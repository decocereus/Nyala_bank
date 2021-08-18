Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :transactions
  get 'transactions/index'
  get 'transactions/new'
  get 'transactions/create'

  devise_for :users, :controllers => {
  registrations: 'registrations'
}
  resource :users

  # resource: home
  root 'home#index'
  get 'home/about'
  get 'home/contact'

  match 'my-account', :to => "users#show", :via => :get
end
