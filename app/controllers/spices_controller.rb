class SpicesController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :spice_not_found
    def create
        spice = Spice.create(spice_params)
        render json: spice, status: :created
    end
    
    def index
        spices = Spice.all
        render json: spices
    end

    def destroy
        spice = find_spice
        spice.destroy
        head :no_content
    end

    def update
        spice = find_spice
        spice.update(spice_params)
        render json: spice
    end

    private

    def spice_params
        params.permit(:title, :image, :description, :notes, :rating )
    end

    def find_spice
        Spice.find(params[:id])
    end

    def spice_not_found
        render json:{error: "Spice not found", status: :not_found}
    end
end
