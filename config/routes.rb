Rails.application.routes.draw do

# 管理者用
# URL /admin/sign_in ...


devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}

namespace :admin do
  get 'top' => 'homes#top', as: 'top'
  resources :genres, only:[:create, :index, :edit, :update, :destroy]
  resources :post_crafts, only:[:index, :show] do
   resources :post_comments, only: [:index, :destroy]
  end
  resources :post_comments, only: [:index]
  resources :users, only:[:index, :show, :edit, :update]
  resources :item_lists, only: [:index, :show] do
   resources :item_list_comments, only: [:index, :destroy]
  end
  resources :item_list_comments, only: [:index]
end

# 顧客用
# URL /customers/sign_in ...
devise_for :users, skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions',
  passwords: 'public/passwords'
}

devise_scope :user do
 post 'users/guest_sign_in', to: 'public/sessions#guest_sign_in'
end

scope module: :public do
  root to: "homes#top"

  get 'users/mypage/:id' => 'users#show', as: 'mypage'
  get 'users/post_crafts' => 'users#index', as: 'user_post_crafts'
  get 'users/user_post_lists/:id' => 'users#user_post_lists', as: 'user_post_lists'
  get 'users/information/edit' => 'users#edit', as: 'edit_information'
  patch 'users/information' => 'users#update', as: 'update_information'
  get 'users/unsubscribe' => 'users#unsubscribe', as: 'confirm_unsubscribe'
  get 'users/favorites' => 'users#favorites', as: 'favorites'
  get 'users/favorite_users' => 'users#favorite_users', as: 'favorite_users'
  get 'users/item_list' => 'users#item_list', as: 'user_item_list'
  get 'post_crafts/confirm' => 'post_crafts#confirm', as: 'post_crafts_confirm'
  get 'post_crafts/tags' => 'post_crafts#tags', as: 'post_crafts_tags'
  get 'post_crafts/post_crafts_by_tag' => 'post_crafts#post_crafts_by_tag', as: 'post_crafts_by_tag'
  get 'item_lists/genre_index' => 'item_lists#genre_index', as: 'item_lists_genre'

  resources :post_crafts, only:[:new, :create, :index, :show, :edit, :update, :destroy] do
    resource :favorites, only: [:create, :destroy]
    resources :post_comments, only: [:create, :destroy]
  end

  resources :tags, only: [:new, :create, :edit, :update]
  resources :genres, only:[:index]

  resources :item_lists, only: [:new, :create, :index, :show, :edit, :update, :destroy] do
    resource :item_favorites, only: [:create, :destroy]
    resources :item_list_comments, only: [:create, :destroy]
  end

  resources :wish_lists, only: [:show, :index, :create, :edit, :update, :destroy]
end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
