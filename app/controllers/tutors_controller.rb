class TutorsController < ApplicationController
  include Decomissionable

  before_action :set_tutor, only: %i[ show edit update destroy ]

  # GET /tutors or /tutors.json
  def index
    @tutors = Tutor.all
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
    respond_to do |format|
      if Tutor.new(tutor_params) == @tutor
        format.html { redirect_to tutor_url(@tutor), alert: "No changes made to tutor." }
      elsif @tutor.update(tutor_params)
        format.html { redirect_to tutor_url(@tutor), notice: "Tutor was successfully updated." }
        format.json { render :show, status: :ok, location: @tutor }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @tutor.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tutors/1 or /tutors/1.json
  def destroy
    can_be_decomissioned = @tutor.run_callbacks(:destroy)

    respond_to do |format|
      if can_be_decomissioned
        decomission_old_version(@tutor, decomission_timestamp: Time.now)
        format.html { redirect_to tutors_url, notice: "Tutor was successfully destroyed." }
        format.json { head :no_content }
      else
        set_flash_alert_with_errors_of(@tutor)
        format.html { redirect_to tutor_url(@tutor) }
      end
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
end
