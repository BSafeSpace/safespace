class AddSignedLiabilityToUsers < ActiveRecord::Migration
  def change
    add_column :users, :signed_liability, :boolean, default: false
  end
end
