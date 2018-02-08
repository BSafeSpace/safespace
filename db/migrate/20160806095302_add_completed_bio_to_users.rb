class AddCompletedBioToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :completed_bio, :boolean, default: false
  end
end
