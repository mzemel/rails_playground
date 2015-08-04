Rails.application.routes.draw do
  resources :messages, only: [:index, :create]
  resources :sessions, only: [:new, :create]

  root 'sessions#new'

  get 'disc', to: "discs#send_delayed_job"
end