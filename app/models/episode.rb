class Episode < ApplicationRecord
  has_one_attached :video
  belongs_to :movie
  has_many :episode_users, dependent: :destroy
end
