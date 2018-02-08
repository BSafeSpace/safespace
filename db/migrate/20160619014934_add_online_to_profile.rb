class AddOnlineToProfile < ActiveRecord::Migration[5.1]
  def change
    add_column :profiles, :online, :boolean, default: false
  end
end
