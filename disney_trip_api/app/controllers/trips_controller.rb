class TripsController < ApplicationController
  before_action :set_trip, only: [:show, :update, :destroy]

  # GET /trips
  def index
    @trips = Trip.all
    render json: @trips
  end

  # GET /trips/1
  def show
    render json: @trip, include: { days: {include: {reservations: { include: {reservable: {except: [:created_at, :updated_at]}}, except: [:created_at, :updated_at]}}, except: [:created_at, :updated_at], methods: [:place]}}, except: [:created_at, :updated_at]
  end

  # POST /trips
  def create
    @trip = Trip.new(trip_params)

    if @trip.save
      render json: @trip, include: :days, except: [:created_at, :updated_at]
    else
      render json: { errors: @trip.errors.full_messages.to_sentence }
    end
  end

  # PATCH/PUT /trips/1
  def update
    if @trip.update(trip_params)
      render json: @trip
    else
      render json: {errors: @trip.errors.full_messages.to_sentence}
    end
  end

  # DELETE /trips/1
  def destroy
    @trip.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_trip
      @trip = Trip.find_by(id: params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def trip_params
      params.require(:trip).permit(:name)
    end
end
