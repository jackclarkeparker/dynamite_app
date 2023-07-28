json.extract! contact, :id, :entity_id, :first_name, :last_name, :full_name, :preferred_name, :email_address, :phone_number, :bank_account, :csc_number, :valid_until, :created_at, :updated_at
json.url contact_url(contact, format: :json)
