class MoviesController < ApplicationController
  before_action :movie, only: %i(destroy update edit)
  before_action :categories, only: %i(new edit)

  def new
    @movie = Movie.new
  end

  def create
    @movie = current_user.movies.build(movie_params)
    if @movie.save
      redirect_to movies_path
    else
      render :new
    end
  end

  def index
    @movies = Movie.includes(:user).all
  end

  def destroy
    @movie.destroy
    redirect_to movies_path
  end

  def edit
  end

  def update
    if @movie.update(movie_params)
      movie.category_ids= params[:movie][:categories]
      redirect_to movies_path
    else
      render :edit
    end
  end

  private

  def movie_params
    params.require(:movie).permit(:name, :rating)
  end

  def movie
    @movie = current_user.movies.find(params[:id])
  end

  def categories
    @categories = Category.all
  end
end
