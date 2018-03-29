class MoviesController < ApplicationController
  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    # update session
    session[:ratings] = params[:ratings] if params.include? :ratings
    session[:sort_by] = params[:sort_by] if params.include? :sort_by
    redirect_to(create_url(session)) if (session[:ratings] != params[:ratings] || session[:sort_by] != params[:sort_by])
    # prepare variables for view
    @all_ratings = Movie.all_ratings
    @sort_type = session[:sort_by]
    @ratings = session[:ratings].nil? ? @all_ratings : session[:ratings]
    @movies = sort_by(movies_by_rating(session[:ratings]), @sort_type)
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

  private

  def redirect?(key)
    (key.nil? || key.empty?) 
  end

  def create_url session
    movies_path(:sort_by => session[:sort_by], :ratings => session[:ratings])
  end

  def movies_by_rating(ratings)
    return Movie.all if ratings.nil? || ratings.empty?
    Movie.all.where(rating: ratings.keys)
  end

  def sort_by(movies, type)
    type = 'title' if type.nil? || type.empty?
    movies.order "#{type}".to_sym
  end
end
