Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  post 'app/auth_token', to: 'authentication#get_jwt_token'
end
