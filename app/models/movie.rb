class Movie < ApplicationRecord
  has_one_attached :image do |attachable|
    attachable.variant :thumb, resize_to_limit: [ 100, 100 ]
  end
  has_many :episodes
  has_and_belongs_to_many :genres

  def first_episode
    self.episodes.order(:position).first
  end
end
