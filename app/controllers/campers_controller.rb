class CampersController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
rescue_from ActiveRecord::RecordInvalid, with: :render_post_unsuccessful_response

    # GET /campers to get all campers
    def index
        render json: Camper.all
    end

    # GET /campers/:id to get a specific camper
    def show
        camper = Camper.find(params[:id])
        if camper
            render json: camper, serializer: CamperWithActivitiesSerializer
        else
            render json: { error: "Camper not found" }, status: :not_found
        end
    end

    def create
        new_camper = Camper.create!(camper_params)
        render json: new_camper, status: :created
    end

    private

    def camper_params
        params.permit(:name, :age)
    end

    def render_not_found_response
        render json: { error: "Camper not found" }, status: :not_found
    end

    def render_post_unsuccessful_response(error_messages)
        render json: { errors: error_messages.record.errors.full_messages }, status: :unprocessable_entity
    end
end
