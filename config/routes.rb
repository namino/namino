Rails.application.routes.draw do
  devise_for :users,
              controllers: {
                confirmations: :confirmations,
                omniauth_callbacks: :callbacks,
                registrations: :registrations
              },
              path_names: { sign_up: 'signup', sign_in: 'signin', sign_out: 'signout' }

  resources :blogs, only: [:new, :create]

  get 'b/:urlname', to: 'blogs#show', as: :blog

  root 'home#index'
end
