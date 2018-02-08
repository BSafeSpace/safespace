class AddNameToProfiles < ActiveRecord::Migration[5.1]
  def change
    add_column :profiles, :name, :string
  end
end
