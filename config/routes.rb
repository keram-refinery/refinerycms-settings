Refinery::Core::Engine.routes.draw do
  namespace :admin, :path => Refinery::Core.backend_route do
    resources :settings, :except => :show if Refinery::Settings.enable_interface

    get '/dialogs/settings' => 'settings_dialog#index'

  end
end
