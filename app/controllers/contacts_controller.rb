class ContactsController < ApplicationController
  include Decomissionable

  before_action :set_contact, only: %i[ show edit update destroy ]

  # GET /contacts or /contacts.json
  def index
    @contacts = Contact.all
  end

  # GET /contacts/1 or /contacts/1.json
  def show
  end

  # GET /contacts/new
  def new
    @contact = Contact.new
  end

  # GET /contacts/1/edit
  def edit
  end

  # POST /contacts or /contacts.json
  def create
    @contact = Contact.new(contact_params)

    respond_to do |format|
      if @contact.save
        format.html { redirect_to contact_url(@contact), notice: "Contact was successfully created." }
        format.json { render :show, status: :created, location: @contact }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /contacts/1 or /contacts/1.json
  def update
    respond_to do |format|
      if Contact.new(contact_params) == @contact
        format.html { redirect_to contact_url(@contact), alert: "No changes made to contact." }
      elsif @contact.update(contact_params)
        format.html { redirect_to contact_url(@contact), notice: "Contact was successfully updated." }
        format.json { render :show, status: :ok, location: @contact }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contacts/1 or /contacts/1.json
  def destroy
    can_be_decomissioned = @contact.run_callbacks(:destroy)

    respond_to do |format|
      if can_be_decomissioned
        decomission_old_version(@contact, decomission_timestamp: Time.now)
        format.html { redirect_to contacts_url, notice: "Contact was successfully destroyed." }
        format.json { head :no_content }
      else
        set_flash_alert_with_errors_of(@contact)
        format.html { redirect_to contact_url(@contact) }
      end
    end
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_contact
      @contact = Contact.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def contact_params
      params.require(:contact).permit(:first_name, :last_name, :full_name, :preferred_name, :email_address, :phone_number, :bank_account, :csc_number, :valid_until, :region_id)
    end
end
