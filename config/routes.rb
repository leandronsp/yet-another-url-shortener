Rails.application.routes.draw do
  get '/:key', to: 'urls#original'
  post '/',    to: 'urls#create'
end
