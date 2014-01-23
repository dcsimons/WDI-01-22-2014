Movie::Application.routes.draw do

    root to: "movies#index"

    get "movies/:id/edit" => "movies#edit", as: :edit_movie

    get "movies/new" => "movies#new", as: :new_movie

    get "movies/:id" => "movies#show", as: :movie
 
    patch "movies/:id" => "movies#update" 

    delete "movies/:id" => "movies#destroy"

end
