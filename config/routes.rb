Rails.application.routes.draw do

# 管理者用
# URL /admin/sign_in ...


devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}

namespace :admin do
  get 'top' => 'homes#top', as: 'top'
  resources :genres, only:[:create, :index, :edit, :update]
  resources :post_crafts, only:[:index, :show]
  resources :users, only:[:index, :show, :edit, :update]
  resources :post_comments, only: [:index, :show, :destroy]
  resources :item_lists, only: [:index, :show]
  resources :item_list_comments, only: [:index, :show, :destroy]
end

# 顧客用
# URL /customers/sign_in ...
devise_for :users,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}


scope module: :public do
  root to: "homes#top"

  get 'users/mypage/:id' => 'users#show', as: 'mypage'
  get 'users/post_crafts' => 'users#index', as: 'user_post_crafts'
  get 'users/index_user/:id' => 'users#index_user', as: 'index_user'
  get 'users/information/edit' => 'users#edit', as: 'edit_information'
  patch 'users/information' => 'users#update', as: 'update_information'
  get 'users/unsubscribe' => 'users#unsubscribe', as: 'confirm_unsubscribe'
  patch 'users/withdraw' => 'users#withdraw', as: 'confirm_withdraw'
  get 'users/favorites' => 'users#favorites', as: 'favorites'
  get 'users/favorite_users' => 'users#favorite_users', as:'favorite_users'
  get 'post_crafts/search' => 'post_crafts#search', as: 'post_crafts_search'
  get 'post_crafts/confirm' => 'post_crafts#confirm', as: 'post_crafts_confirm'

  resources :post_crafts, only:[:new, :create, :index, :show, :edit, :update, :destroy] do
    resource :favorites, only: [:create, :destroy]
    resources :post_comments, only: [:create, :destroy]
   end

  resources :item_lists, only: [:new, :create, :index, :show, :edit, :update, :destroy] do
    resource :item_favorites, only: [:create, :destroy]
    resources :item_list_comments, only: [:create, :destroy]
   end

  resources :wish_lists, only: [:index, :create, :edit, :update, :destroy]
end

devise_scope :user do
  post 'users/guest_sign_in', to: 'public/sessions#guest_sign_in'
end




  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
