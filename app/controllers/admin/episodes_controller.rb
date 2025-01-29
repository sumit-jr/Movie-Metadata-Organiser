class Admin::EpisodesController < AdminController
  before_action :set_movie
  before_action :set_episode, only: [ :move ]
  def index
    @admin_episodes = @admin_movie.episodes.order(:position)
  end
  def move
    position = params[:position].to_i
    if position == 0
      @admin_episode.move_to_top
    elsif position == @admin_movie.episodes.count - 1
      @admin_episode.move_to_bottom
    else
      @admin_episode.insert_at(position + 1)
    end

    @admin_episode.save!

    render json: { message: "success" }
  end
  def show
  end
  def edit
  end


  def set_movie
    @admin_movie = Movie.find(params[:movie_id])
  end

  def set_episode
    @admin_episode = Episode.find(params[:id])
  end
end
