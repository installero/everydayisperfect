Everydayisperfect::Application.routes.draw do
  resources :events
  root :to => 'events', :action => 'index'
end
