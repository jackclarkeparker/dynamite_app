module ErrorToFlash
  private

    def set_flash_alert_with_errors_of(model_instance)
      error_messages = model_instance.errors.full_messages.join("\n")
      error_messages.gsub!("\n", "<br>")
      flash[:alert] = error_messages
    end
end