class AddShowcaseToUsers < ActiveRecord::Migration
  def change
    add_column :users, :showcase, :boolean, default: false
  end
end
