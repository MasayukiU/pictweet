Rails.application.routes.draw do
  devise_for :users #userGemで自動生成ユーザー機能に必要な複数のルーティングを一度に生成してくれるdeviseのメソッド
  root to: 'tweets#index' #ホーム画面を表示するための記述ルートパス
  resources :tweets do#7つのアクションの集合
    resources :comments, only: :create#今回は「コメントを投稿する」機能、つまり「コメント情報を作る機能」を実装するのでcreateアクションのルーティングとします。
    collection do
      get 'search'#collectionとmemberがある
    end
  end#どのツイートに対するコメントなのかをパスから判断できるようにしたいので、ここではルーティングのネストという方法を使っていきます。
  resources :users, only: :show
end
# ////////////////////////////////

# root   "posts#index"
# post   "posts"          => "posts#create"
# get    "posts/new"      => "posts#new"
# get    "posts/:id/edit" => "posts#edit"
# get    "posts/:id"      => "posts#show"
# patch  "posts/:id"      => "posts#update"
# delete "posts/:id"      => "posts#destroy"

# ////////////////////////////////

# get    "users"          => "users#index"
# post   "users"          => "users#create"
# get    "users/new"      => "users#new"
# get    "users/:id/edit" => "users#edit"
# get    "users/:id"      => "users#show"
# patch  "users/:id"      => "users#update"
# delete "users/:id"      => "users#destroy"