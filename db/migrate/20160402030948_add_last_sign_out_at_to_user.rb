class AddLastSignOutAtToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :last_sign_out_at, :datetime
  end
end
