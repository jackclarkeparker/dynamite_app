class RegionsController < ApplicationController
  before_action :set_region, only: %i[ show edit update destroy ]

  # GET /regions or /regions.json
  def index
    @regions = Region.all
  end

  # GET /regions/1 or /regions/1.json
  def show
  end

  # GET /regions/new
  def new
    @region = Region.new
  end

  # GET /regions/1/edit
  def edit
  end

  # POST /regions or /regions.json
  def create
    @region = Region.new(region_params)

    respond_to do |format|
      if @region.save
        format.html { redirect_to regions_url, notice: "Region was successfully created." }
        format.json { render :show, status: :created, location: @region }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @region.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /regions/1 or /regions/1.json
  def update
    respond_to do |format|
      if Region.new(region_params) == @region
        format.html do
          redirect_to regions_url, alert: "No changes made to region."
        end
      elsif @region.update(region_params)
        format.html { redirect_to regions_url, notice: "Region was successfully updated." }
        format.json { render :show, status: :ok, location: @region }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @region.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /regions/1 or /regions/1.json
  def destroy
    respond_to do |format|
      if @region.destroy
        format.html { redirect_to regions_url, notice: "Region was successfully destroyed." }
        format.json { head :no_content }
      else
        set_flash_alert_with_errors_of(@region)
        format.html { redirect_to regions_url }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_region
      @region = Region.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def region_params
      params.require(:region).permit(:name)
    end
end
