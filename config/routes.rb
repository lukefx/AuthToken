Rails.application.routes.draw do

  post '/tokens/:provider', to: 'tokens#create'
  get 'tokens', to: 'tokens#index'
  get 'tokens/new', to: 'tokens#new'
  get 'tokens/:token', to: 'tokens#index'

end
