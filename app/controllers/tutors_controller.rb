class TutorsController < ApplicationController
  include EntityHelpers

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
    new_version = Tutor.new(tutor_params)
    new_version.entity_id = @tutor.entity_id

    respond_to do |format|
      if new_version == @tutor
        format.html do
          redirect_to tutor_url(@tutor), alert: "No changes made to tutor."
        end
      elsif new_version.save
        decomission_old_version(decomission_timestamp: new_version.created_at)
        format.html do
          redirect_to tutor_url(new_version), notice: "Tutor was successfully updated."
        end
        format.json { render :show, status: :ok, location: new_version }
      else
        @id_for_url = @tutor.id
        @tutor = new_version
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
        decomission_old_version(decomission_timestamp: Time.now)
        format.html { redirect_to tutors_url, notice: "Tutor was successfully destroyed." }
        format.json { head :no_content }
      else
        error_messages = @tutor.errors.full_messages.join("\n")
        flash[:alert] = error_messages.gsub("\n", "<br>")
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

    def decomission_old_version(decomission_timestamp:)
      @tutor.valid_until = decomission_timestamp
      @tutor.save
    end
end
