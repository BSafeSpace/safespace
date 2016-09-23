class AddCounselorHoursToProfiles < ActiveRecord::Migration
  def change
    add_column :profiles, :counselor_hours, :string
  end
end
