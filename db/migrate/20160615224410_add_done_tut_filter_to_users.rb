class AddDoneTutFilterToUsers < ActiveRecord::Migration
  def change
    add_column :users, :done_tut_filter, :boolean, :default => false
  end
end
