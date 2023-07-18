class AddValidUntilToTutors < ActiveRecord::Migration[7.0]
  def change
    add_column :tutors, :valid_until, :timestamp
  end
end
