class AddUnseenCountToUsers < ActiveRecord::Migration
  def change
    add_column :users, :unseen_count, :integer
  end
end
