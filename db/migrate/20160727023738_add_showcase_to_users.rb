class AddShowcaseToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :showcase, :boolean, default: false
  end
end
