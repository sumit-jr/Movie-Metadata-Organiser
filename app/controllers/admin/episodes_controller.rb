class Admin::EpisodesController < AdminController
  before_action :set_movie
  before_action :set_episode, only: [ :move, :show, :edit, :update, :destroy  ]
  def create
    @admin_episode = @admin_movie.episodes.new(episode_params)

    if @admin_episode.save
      redirect_to admin_movie_episodes_path(@admin_movie)
    else
      render :new
    end
  end

  def destroy
    @admin_episode.destroy!
    redirect_to admin_movie_episodes_path(@admin_movie)
  end
  def edit
  end
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
  def new
    @admin_episode = @admin_movie.episodes.new
  end
  def show
  end

  def update
    if @admin_episode.update(episode_params)
      redirect_to admin_movie_episodes_path(@admin_movie)
    else
      render :edit
    end
  end

  private

  def episode_params
    params.require(:episode).permit(:title, :description, :video, :paid, :position)
  end
  def set_movie
    @admin_movie = Movie.find(params[:movie_id])
  end

  def set_episode
    @admin_episode = Episode.find(params[:id])
  end
end
