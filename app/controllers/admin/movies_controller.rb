class Admin::MoviesController < ApplicationController
  def index
    @admin_movies = Movie.all
  end
end
