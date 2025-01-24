class CheckoutsController < ApplicationController
  before_action :authenticate_user!

  stripe_secret_key = Rails.application.credentials.dig(:stripe, :secret_key)
  Stripe.api_key = stripe_secret_key
  def create
    movie = Movie.find(params[:movie_id])

    begin
      session = Stripe::Checkout::Session.create(
        payment_method_types: [ "card" ],
        mode: "payment",
        line_items: [ {
          price: movie.stripe_price_id,
          quantity: 1
        } ],
        success_url: request.base_url + "/movies/#{movie.id}",
        cancel_url: request.base_url + "/movies/#{movie.id}",
        customer_email: current_user.email,
        metadata: { movie_id: movie.id }
      )
      puts "Stripe session created: #{session.inspect}"
      redirect_to session.url, allow_other_host: true
    rescue Stripe::StripeError => e
      puts "Stripe error: #{e.message}"
      render json: { error: e.message }, status: 400
    end
  end
end
