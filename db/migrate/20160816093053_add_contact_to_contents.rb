class AddContactToContents < ActiveRecord::Migration
  def change
    add_column :contents, :contact, :text
  end
end
