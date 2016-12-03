Rails.application.routes.draw do
  resources :tags, only: [:show]
  mount Ckeditor::Engine => '/ckeditor'
  resources :posts
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'posts#index'
end
