class AddOnlineToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :online, :boolean, default: false
  end
end
