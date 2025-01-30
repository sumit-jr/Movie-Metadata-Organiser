class Admin::UsersController < AdminController
  def index
    if params[:query].present?
      @admin_users = User.where("email LIKE ?", "%#{params[:query]}%").order(created_at: :desc)
    else
      @admin_users = User.all.order(created_at: :desc)
    end
  end

  def show
    @admin_user = User.find(params[:id])
    @user_started_movies = @admin_user.episode_users&.joins(:episode)&.pluck(:movie_id)&.uniq
    @admin_movies = Movie.where(id: @user_started_movies)
    if @user_started_movies.present?
      @user_movie_progresses = @user_started_movies.map do |movie_id|
        movie_episodes = Movie.find(movie_id).episodes.count
        completed_episodes = @admin_user&.episode_users&.joins(:episode)&.where(completed: true, episode: { movie: movie_id })&.count
        { movie_id: movie_id, completed_percentage: (completed_episodes.to_f / movie_episodes.to_f * 100).to_i }
      end
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy!
    redirect_to admin_users_path
  end
end
