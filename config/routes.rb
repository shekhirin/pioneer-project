Rails.application.routes.draw do
  root 'questions#index'

  resources :questions do
    resources :replies
  end

  get 'newest' => 'questions#newest'

  resources :tags
end
