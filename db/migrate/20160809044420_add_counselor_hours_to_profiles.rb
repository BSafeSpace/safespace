class AddCounselorHoursToProfiles < ActiveRecord::Migration[5.1]
  def change
    add_column :profiles, :counselor_hours, :string
  end
end
