class EpisodesController < ApplicationController
  before_action :set_episode, only: %i[ show update ]
  def show
    @movie = @episode.movie
  end

  def update
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_episode
      @episode = Episode.find(params[:id])
    end
end
