class CheckoutsController < ApplicationController
  before_action :authenticate_user!

  stripe_secret_key = Rails.application.credentials.dig(:stripe, :secret_key)
  Stripe.api_key = stripe_secret_key
  def create
    movie = Movie.find(params[:movie_id])

    session = Stripe::Checkout::Session.create(
      mode: "payment",
      line_items: [ {
        price: movie.stripe_price_id,
        quantity: 1
  } ],
  success_url: request.base_url + "/movies/#{movie.id}",
  cancel_url: request.base_url + "/movies/#{movie.id}",
  automatic_tax: { enabled: true },
  customer_email: current_user.email,
  metadata: { movie_id: movie.id }
    )
    redirect_to session.url, allow_other_host: true
  end
end
