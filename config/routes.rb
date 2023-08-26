Rails.application.routes.draw do

# 管理者用
# URL /admin/sign_in ...
devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}

namespace :admin do
  get 'top' => 'homes#top', as: 'top'
end


# 顧客用
# URL /customers/sign_in ...
devise_for :users,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}


scope module: :public do
  root to: "homes#top"

  get 'users/mypage' => 'users#show', as: 'mypage'
  get 'users/information/edit' => 'users#edit', as: 'edit_information'
  patch 'users/information' => 'users#update', as: 'update_information'
  get 'users/unsubscribe' => 'users#unsubscribe', as: 'confirm_unsubscribe'
  patch 'users/withdraw' => 'users#withdraw', as: 'confirm_withdraw'

  resources :post_crafts, only:[:index, :new, :create, :show, :edit, :update, :destroy]


end

devise_scope :user do
  post 'users/guest_sign_in', to: 'public/sessions#guest_sign_in'
end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
