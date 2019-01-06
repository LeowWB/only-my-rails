Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get "/" => "task#index"
  get "/new" => "task#new"
  post "/new" => "task#create"

  get "/tasks/:id" => "task#show", as: :task
  get "/tasks/:id/edit" => "task#edit", as: :edit_task
  patch "/tasks/:id" => "task#update"
  
end
