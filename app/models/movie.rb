class Movie < ApplicationRecord
  has_one_attached :image do |attachable|
    attachable.variant :thumb, resize_to_limit: [ 100, 100 ]
  end
  has_many :episodes
  has_many :movie_users
  has_and_belongs_to_many :genres
  has_rich_text :description
  has_rich_text :premium_description

  def first_episode
    self.episodes.order(:position).first
  end

  def next_episode(current_user)
    if current_user.blank?
      return self.episodes.order(:position).first
    end
    completed_episodes = current_user.episode_users.includes(:episode).where(completed: true).where(episodes: { movie_id: self.id })
    started_episodes = current_user.episode_users.includes(:episode).where(completed: false).where(episodes: { movie_id: self.id }).order(:position)

    if started_episodes.any?
      return started_episodes.first.episode
    end

    episodes = self.episodes.where.not(id: completed_episodes.pluck(:episode_id)).order(:position)
    if episodes.any?
      episodes.first
    else
      self.episodes.order(:position).first
    end
  end
end
