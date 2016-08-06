class AddCompletedBioToUsers < ActiveRecord::Migration
  def change
    add_column :users, :completed_bio, :boolean, default: false
  end
end
