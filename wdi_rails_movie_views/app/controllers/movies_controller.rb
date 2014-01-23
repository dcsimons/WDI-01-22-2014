class MoviesController < ApplicationController

  @@movie_db = [
          {"title"=>"The Matrix", "year"=>"1999", "imdbID"=>"tt0133093", "Type"=>"movie"},
          {"title"=>"The Matrix Reloaded", "year"=>"2003", "imdbID"=>"tt0234215", "Type"=>"movie"},
          {"title"=>"The Matrix Revolutions", "year"=>"2003", "imdbID"=>"tt0242653", "Type"=>"movie"}]

  # route: GET    /movies(.:format)
  def index
    @movies = @@movie_db.sort_by { |movie| movie["title"] }

    respond_to do |format|
      format.html
      format.json { render :json => @@movie_db }
      format.xml { render :xml => @@movie_db.to_xml }
    end
  end

  # route: # GET    /movies/:id(.:format)
  def show
    @movie = get_movie(params[:id])
    render :show
  end

  # route: GET    /movies/new(.:format)
  def search
    search_str = params[:movie]

    response = Typhoeus.get("www.omdbapi.com", :params => {:s => search_str})
    result = JSON.parse(response.body)

    if result["Search"] == nil
      redirect_to "/"
    else  
      @movie_array = result["Search"].sort_by { |movie| movie["Year"] }.reverse
      
      @movie_array.each do |x|
        @@movie_db << {"title" => x["Title"], "year" => x["Year"], "imdbID" => x["imdbID"], "Type"=>"movie"}
      end
      
      render :search
    end
  end

  # route: GET    /movies/:id/edit(.:format)
  def edit
    @movie = get_movie(params[:id])
    render :edit
  end

  #route: # POST   /movies(.:format)
  def create
    # create new movie object from params
    movie = params.require(:movie).permit(:title, :year)
    movie["imdbID"] = rand(10000..100000000).to_s
    # add object to movie db
    @@movie_db << movie
    # show movie page
    # render :index
    redirect_to action: :index
  end

  # route: PATCH  /movies/:id(.:format)
  def update
    @movie = get_movie(params[:id])
    @@movie_db.delete(@movie)
    # movie["title"] = params[:movie][:title]
    # movie["year"] = params[:movie][:year]
    @movie = params.require(:movie).permit(:title, :year)
    @movie['imdbID']=params[:id]
    @@movie_db << @movie
    render :show
  end

  # route: DELETE /movies/:id(.:format)
  def destroy
    movie = get_movie(params[:id])
    @@movie_db.delete(movie)
    redirect_to "/"
  end

  private

  def get_movie(movie_id)
    the_movie = @@movie_db.find do |m|
        m["imdbID"] == movie_id
      end

      if the_movie.nil?
        flash.now[:message] = "Movie not found"
        the_movie = {}
      end
    return the_movie
  end

end
