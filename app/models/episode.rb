class Episode < ApplicationRecord
  has_one_attached :video do |attachable|
    attachable.variant :thumb, resize_to_limit: [ 500, 500 ]
  end
  acts_as_list
  has_rich_text :description
  belongs_to :movie
  has_many :episode_users, dependent: :destroy

  def next_episode
    movie.episodes.where("position > ?", position).order(:position).first
  end

  def previous_episode
    movie.episodes.where("position < ?", position).order(:position).last
  end
end
