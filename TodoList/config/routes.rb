Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get "/" => "task#index"
  get "/new" => "task#new"
  post "/new" => "task#create"

  get "/tasks/:id" => "task#show", as: :task
  get "/tasks/:id/edit" => "task#edit", as: :edit_task
  patch "/tasks/:id" => "task#update"
  delete "/tasks/:id" => "task#destroy"

  post "/tasks/:id/" => "tag#create"
  delete "/tasks/:id/delete_tag/:tag_id" => "tag#destroy"
  
  get "/search" => "task#search"
  post "/search" => "task#results"
end
