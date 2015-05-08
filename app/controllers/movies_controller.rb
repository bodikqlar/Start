class MoviesController < ApplicationController
  before_action :movie, only: %i(destroy update edit)
  before_action :categories, only: %i(new edit)

  def new
    @movie = Movie.new
  end

  def create
    @movie = current_user.movies.build(movie_params)
    if @movie.save
      redirect_to movies_path, notice: t('movie.successful_create')
    else
      render :new
    end
  end

  def index
    @movies = Movie.includes(:user)
  end

  def destroy
    if @movie.destroy
      redirect_to movies_path, notice: t('movie.successful_destroy')
    else
      redirect_to movies_path, alert: t('movie.error_destroy')
    end
  end

  def edit
  end

  def update
    if @movie.update(movie_params)
      movie.category_ids= params[:movie][:categories]
      redirect_to movies_path, notice: t('movie.successful_update')
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
