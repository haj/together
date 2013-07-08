Dummy::Application.routes.draw do
  
  root 'home#index'

  get '/app' => 'app#index', as: :app
end
