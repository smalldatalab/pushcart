Pushcart::Application.routes.draw do

  devise_for :coaches
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  ### API ###

    scope 'api' do
      scope 'v1' do
        use_doorkeeper
      end

      api_version(module: 'api/v1', path: {value: 'v1'}, defaults: {format: 'json'}) do
        resources :users, only: [:show, :index] do
          resources :purchases, only: [:show, :index] do
            resources :itemizables, path: 'items', only: [:show, :index, :update]
          end
          resources :itemizables, path: 'items', only: [:show, :update]
          resources :messages
        end
        resources :swap_categories, only: :index
        resources :swaps, only: [:index, :create]
        resources :memberships, only: [] do
          post :invite, on: :collection
        end
      end
    end

  ######

  ### User Site ###
    resources :users, only: [:edit, :update]
    resources :items, only: [] do
      get :swap_feedback,  on: :member
    end
    resources :memberships, only: [:new, :create]
    devise_for :users, controllers: {
                                      registrations: 'user_registrations',
                                      confirmations: 'user_confirmations',
                                      omniauth_callbacks: 'users/omniauth_callbacks'
                                    }

    get 'account_confirmation',      to: 'users#account_confirmation'
    get 'my_account',                to: 'users#my_account'
    get 'thank_you_for_registering', to: 'users#thank_you_for_registering'
    get 'login_token_expired',       to: 'users#login_token_expired'
    post 'new_authentication_token', to: 'users#new_authentication_token'
    get 'edit_household',            to: 'users#edit_household'
    delete 'sign_out',               to: 'users#log_out',  as: 'sign_out_user'
  ######

  ### Email ###
    mount_griddler

    # # Temporary route just used to validate Mandrill. See: https://github.com/thoughtbot/griddler#using-griddler-with-mandrill
    # get "/email_processor", to: proc { [200, {}, ["OK"]] }, as: "mandrill_head_test_request"

  root to: 'application#index'
end
