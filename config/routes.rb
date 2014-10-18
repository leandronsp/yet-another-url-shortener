Rails.application.routes.draw do
  get '/:key', to: 'urls#original'
  post '/',    to: 'urls#create'
  root to: 'home#index'
end
