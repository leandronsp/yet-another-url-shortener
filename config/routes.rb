Rails.application.routes.draw do
  get  '/sign_in',  to: 'sessions#new',     as: :sign_in
  post '/sign_in',  to: 'sessions#create'

  get  '/sign_up',  to: 'users#new',        as: :sign_up
  post '/sign_up',  to: 'users#create'

  get  '/logout',   to: 'sessions#destroy', as: :logout

  namespace :manage do
    get '/', to: 'urls#index'
  end

  get '/:key', to: 'urls#original'
  post '/',    to: 'urls#create'


  root to: 'home#index'
end
