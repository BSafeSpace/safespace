class AddDoneTutFilterToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :done_tut_filter, :boolean, :default => false
  end
end
