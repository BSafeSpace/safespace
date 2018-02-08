class AddUnseenCountToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :unseen_count, :integer
  end
end
