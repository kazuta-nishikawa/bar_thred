Rails.application.routes.draw do
  get 'relationships/create'
  get 'relationships/destroy'
  get 'posts/index'
  devise_for :users
  root to: 'toppages#index'
  
  resources :users do
    member do
      get :followings
      get :followers
    end
    collection do
      get :search
    end
  end
  
  resources :recipes
  
  # コメントはレシピページで表示するため、一覧や詳細などは不要、発言の取り消しや編集はさせない
  resources :posts,only:[:create]
  
  # フォロー・アンフォローの機能用
  resources :relationships, only: [:create, :destroy]
end
