class Episode < ApplicationRecord
  has_one_attached :video
  belongs_to :movie
  has_many :episode_users, dependent: :destroy

  def next_episode
    movie.episodes.where("position > ?", position).order(:position).first
  end

  def previous_episode
    movie.episodes.where("position < ?", position).order(:position).last
  end
end
