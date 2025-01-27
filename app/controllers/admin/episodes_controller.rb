class Admin::EpisodesController < AdminController
  before_action :set_movie
  def index
    @admin_episodes = @admin_movie.episodes.order(:position)
  end
  def set_movie
    @admin_movie = Movie.find(params[:movie_id])
  end
end
