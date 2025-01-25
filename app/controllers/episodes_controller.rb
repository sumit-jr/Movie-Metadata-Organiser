class EpisodesController < ApplicationController
  before_action :set_episode, only: %i[ show update ]
  before_action :set_movie
  def show
    @completed_episodes = current_user.episode_users.where(completed: true).pluck(:episode_id)
    @movie = @episode.movie
    @paid_for_movie = current_user.movie_users.where(movie: @movie).exists?
    puts "paid_for_movie: #{@paid_for_movie}"
  end

  def update
    @episode_user = EpisodeUser.find_or_create_by(episode: @episode, user: current_user)
    @episode_user.update!(completed: true)
    next_episode = @movie.episodes.where("position > ?", @episode.position).order(:position).first
    if next_episode
      redirect_to movie_episode_path(@movie, next_episode)
    else
      redirect_to movie_path(@movie), notice: "You've completed the movie"
    end
  end

  private

  def set_movie
    @movie = Movie.find(params[:movie_id])
  end
    # Use callbacks to share common setup or constraints between actions.
    def set_episode
      @episode = Episode.find(params[:id])
    end
end
