Rails.application.routes.draw do
  resources :resources, :only => [:index], :controller => 'xing/root_resources'
end
