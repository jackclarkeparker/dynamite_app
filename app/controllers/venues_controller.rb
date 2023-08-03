class VenuesController < ApplicationController
  before_action :set_venue, only: %i[ show edit update destroy ]

  # GET /venues or /venues.json
  def index
    @venues_by_region = Venue.includes(:region).order(:region_id, 'venues.name')
                             .reduce({}) do |venue_list, venue|
      venue_list[venue.region.name] ||= []
      venue_list[venue.region.name] << venue
      venue_list
    end
  end

  # GET /venues/1 or /venues/1.json
  def show
  end

  # GET /venues/new
  def new
    @venue = Venue.new
  end

  # GET /venues/1/edit
  def edit
  end

  # POST /venues or /venues.json
  def create
    @venue = Venue.new(venue_params)

    respond_to do |format|
      if @venue.save
        format.html { redirect_to venue_url(@venue), notice: "Venue was successfully created." }
        format.json { render :show, status: :created, location: @venue }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @venue.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /venues/1 or /venues/1.json
  def update
    respond_to do |format|
      if Venue.new(venue_params) == @venue
        format.html { redirect_to venue_url(@venue), alert: "No changes made to venue." }
        format.json { render :show, status: :ok, location: @venue }
      elsif @venue.update(venue_params)
        format.html { redirect_to venue_url(@venue), notice: "Venue was successfully updated." }
        format.json { render :show, status: :ok, location: @venue }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @venue.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /venues/1 or /venues/1.json
  def destroy
    respond_to do |format|
      if @venue.destroy
        format.html { redirect_to venues_url, notice: "Venue was successfully destroyed." }
        format.json { head :no_content }
      else
        set_flash_alert_with_errors_of(@venue)
        format.html { redirect_to venue_url(@venue) }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_venue
      @venue = Venue.find(params[:id])
    end

    def set_regions
      @regions = Region.all
    end

    # Only allow a list of trusted parameters through.
    def venue_params
      params.require(:venue).permit(:name, :address, :region_id, :standard_price)
    end
end
