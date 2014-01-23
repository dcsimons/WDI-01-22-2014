class MoviesController < ApplicationController

	@@movies_db = [
            {"title"=>"The Matrix", "year"=>"1999", "imdbID"=>"tt0133093", "type"=>"movie"},
            {"title"=>"The Matrix Reloaded", "year"=>"2003", "imdbID"=>"tt0234215", "type"=>"movie"},
            {"title"=>"The Matrix Revolutions", "year"=>"2003", "imdbID"=>"tt0242653", "type"=>"movie"}]

    def index
        @movies = @@movies_db             
    end

    def new

    end

    def show
    	@movie = @@movies_db[0]
    end

    def edit
    	@movie = @@movies_db[1]
    end

end
