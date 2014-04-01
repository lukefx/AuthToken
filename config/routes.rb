Rails.application.routes.draw do

  get 'tokens', to: 'tokens#index'
  get 'tokens/:token', to: 'tokens#index'
  post 'tokens', to: 'tokens#create'

end
