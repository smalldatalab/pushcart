Pushcart::Application.routes.draw do

  ### API ###

  scope 'api' do
    scope 'v1' do
      use_doorkeeper
    end

    api_version(:module => "api/v1", :path => {:value => "v1"}, :defaults => {:format => "json"}) do
      resources :users, only: [:show, :index] do
        resources :purchases, only: [:show, :index] do
          resources :items, only: [:show, :index]
        end
      end
    end
  end

  ###

  ### User Site ###
    resources :users, only: [:edit, :update]
    devise_for :users, controllers: {
                                      registrations: "user_registrations",
                                      confirmations: "user_confirmations"
                                    }
    get 'account_confirmation',      to: 'users#account_confirmation'
    get 'thank_you_for_registering', to: 'users#thank_you_for_registering'
    get 'login_token_expired',       to: 'users#login_token_expired'
    post 'new_login_token',          to: 'users#new_login_token'
    delete 'sign_out',               to: 'users#log_out',  as: 'sign_out_user'
  ######

  # Temporary route just used to validate Mandrill. See: https://github.com/thoughtbot/griddler#using-griddler-with-mandrill
  get "/email_processor", to: proc { [200, {}, ["OK"]] }, as: "mandrill_head_test_request"

  root to: "application#index"
end
