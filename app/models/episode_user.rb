class EpisodeUser < ApplicationRecord
  belongs_to :episode
  belongs_to :user
end
