class Episode < ApplicationRecord
  has_one_attached :video
  belongs_to :movie
end
