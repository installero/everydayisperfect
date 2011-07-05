Everydayisperfect::Application.routes.draw do
  devise_for :users

  resources :events
  root :to => 'events', :action => 'index'
end
