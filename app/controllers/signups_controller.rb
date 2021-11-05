class SignupsController < ApplicationController
    rescue_from ActiveRecord::RecordInvalid, with: :render_signup_unsuccessful_response
    def create
        new_signup = Signup.create!(signup_params)
        render json: new_signup.activity, status: :created
    end

    private

    def signup_params
        params.permit(:time, :camper_id, :activity_id)
    end

    def render_signup_unsuccessful_response (error_messages)
        render json: { errors: error_messages.record.errors.full_messages}, status: :unprocessable_entity
    end
end
