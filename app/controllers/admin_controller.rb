class AdminController < ApplicationController
  before_action :authenticate_admin!
  def index
    @quick_stats = {
      sign_ups: User.where("created_at > ?", 1.week.ago).count,
      sales: MovieUser.where("created_at>?", 1.week.ago).count,
      completed_episodes: EpisodeUser.where("created_at > ?", 1.week.ago).where(completed: true).count,
      total_sign_ups: User.count
    }
    @completed_episodes_by_day = EpisodeUser.where("created_at > ?", 1.week.ago).where(completed: true).group_by_day(:created_at, format: "%A").count
    @sign_ups_by_day = User.where("created_at > ?", 1.week.ago).group_by_day(:created_at, format: "%A").count
    @most_popular_movies = Movie.joins(:movie_users).group(:id).order("count(movie_users.id) desc").limit(5)
  end
end
