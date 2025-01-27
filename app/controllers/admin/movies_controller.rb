class Admin::MoviesController < AdminController
  def show
    @admin_movie = Movie.find(params[:id])
  end
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

  def edit
    @admin_movie = Movie.find(params[:id])
  end

  def update
    @admin_movie = Movie.find(params[:id])

    if @admin_movie.update(movie_params)
      redirect_to admin_movies_path
    else
      render :edit
    end
  end

  private
  def movie_params
    params.require(:movie).permit(:title, :description, :premium_description, :paid, :stripe_price_id, :image)
  end
end
