Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/solicitud', to: 'static#home'
  post '/solicitud', to: 'static#help', as: 'help'
  root 'static#home'
end
