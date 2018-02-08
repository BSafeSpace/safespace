class AddSignedLiabilityToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :signed_liability, :boolean, default: false
  end
end
