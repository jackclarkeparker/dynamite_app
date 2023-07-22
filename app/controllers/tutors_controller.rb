class TutorsController < ApplicationController
  include EntityHelpers
  include SelectData
  before_action :set_regions, only: %i[ new create edit update ]
  before_action :set_tutor, only: %i[ show edit update destroy ]

  # GET /tutors or /tutors.json
  def index
    @tutors = Tutor.all.where(valid_until: ApplicationRecord::FUTURE_EPOCH)
  end

  # GET /tutors/1 or /tutors/1.json
  def show
  end

  # GET /tutors/new
  def new
    @tutor = Tutor.new
  end

  # GET /tutors/1/edit
  def edit
  end

  # POST /tutors or /tutors.json
  def create
    @tutor = Tutor.new(tutor_params)
    set_entity_id(@tutor)

    respond_to do |format|
      if @tutor.save
        format.html { redirect_to tutor_url(@tutor), notice: "Tutor was successfully created." }
        format.json { render :show, status: :created, location: @tutor }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @tutor.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tutors/1 or /tutors/1.json
  def update
    new_tutor = Tutor.new(tutor_params)
    new_tutor.entity_id = @tutor.entity_id

    respond_to do |format|
      if new_tutor.same_attributes_as(@tutor)
        format.html do
          redirect_to tutor_url(@tutor), alert: "No changes made to tutor."
        end
      elsif new_tutor.save
        decomission_old_version(decomission_timestamp: new_tutor.created_at)
        format.html do
          redirect_to tutor_url(new_tutor), notice: "Tutor was successfully updated."
        end
        format.json { render :show, status: :ok, location: new_tutor }
      else
        @tutor = new_tutor
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @tutor.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tutors/1 or /tutors/1.json
  def destroy
    @tutor.valid_until = Time.now
    @tutor.save

    respond_to do |format|
      format.html do
        redirect_to tutors_url, notice: "Tutor was successfully destroyed."
      end
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tutor
      @tutor = Tutor.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def tutor_params
      params.require(:tutor).permit(
        :first_name, :last_name, :preferred_name,
        :email_address, :phone_number,
        :region_id, :delivery_address
      )
    end

    def decomission_old_version(decomission_timestamp:)
      @tutor.valid_until = decomission_timestamp
      @tutor.save
    end
end
