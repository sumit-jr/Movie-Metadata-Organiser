class WebhooksController < ApplicationController
  skip_forgery_protection

  def stripe
    stripe_secret_key = Rails.application.credentials.dig(:stripe, :secret_key)
    Stripe.api_key = stripe_secret_key
    payload = request.body.read
    sig_header = request.env["HTTP_STRIPE_SIGNATURE"]
    endpoint_secret = Rails.application.credentials.dig(:stripe, :webhook_secret)

    begin
      event = Stripe::Webhook.construct_event(payload, sig_header, endpoint_secret)
    rescue JSON::ParserError => e
      render json: { error: "Invalid payload" }, status: 400 and return
    rescue Stripe::SignatureVerificationError => e
      render json: { error: "Invalid signature" }, status: 400 and return
    end

    case event.type
    when "checkout.session.completed"
      session = event.data.object

      begin
        full_session = Stripe::Checkout::Session.retrieve(
          id: session.id,
          expand: [ "line_items" ]
        )

        movie_id = full_session.metadata["movie_id"]
        movie = Movie.find_by(id: movie_id)

        unless movie
          puts "Movie with ID #{movie_id} not found"
          render json: { error: "Movie not found" }, status: 404 and return
        end

        user = User.find_by(email: full_session.customer_email)

        unless user
          puts "User with email #{full_session.customer_email} not found"
          render json: { error: "User not found" }, status: 404 and return
        end

        MovieUser.create!(movie: movie, user: user)

      rescue ActiveRecord::RecordNotFound => e
        render json: { error: "Record not found" }, status: 404 and return
      rescue => e
        render json: { error: "Internal server error" }, status: 500 and return
      end
    else
      Rails.logger.info "Unhandled event type: #{event.type}"
    end

    render json: { message: "Webhook processed successfully" }, status: 200
  end
end
