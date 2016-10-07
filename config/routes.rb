Rails.application.routes.draw do
  get 'welcome/index'

  resources :user_contacts

  resources :roles do
    collection do
      delete 'destroy_multiple'
    end
  end

  devise_for :users, controllers: {
    #sessions: "users/sessions",
    registrations: "users/registrations",
    omniauth_callbacks: "users/omniauth_callbacks"
  }

  devise_scope :user do
#    get 'devise/sessions/sign_out' => 'devise/sessions#destroy', as: :destroy_session
#    match 'devise/registrations/:id/edit' => 'devise/registrations#edit', as: :edit_user, via: :get
    match 'users/:id/edit' => 'users#edit', as: :edit_admin_user, via: :get
  end
  
  resources :users do
    collection do
      delete 'destroy_multiple'
    end
  end
  root 'welcome#index'
end
