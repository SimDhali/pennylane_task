Rails.application.routes.draw do
  root 'recipes#index'
  
  resources :recipes do
    post 'try', on: :member
    post 'untry', on: :member
  end
end
