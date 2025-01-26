class Admin::MoviesController < AdminController
  def index
    @admin_movies = Movie.all
  end

  def new
    @admin_movie = Movie.new
  end

  def create
    @admin_movie = Movie.new(movie_params)
    if @admin_movie.save
      redirect_to admin_movies_path
    else
      render :new
    end
  end

  private
  def movie_params
    params.require(:movie).permit(:title, :description, :premium_description, :paid, :stripe_price_id, :image)
  end
end
