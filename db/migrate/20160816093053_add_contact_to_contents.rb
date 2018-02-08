class AddContactToContents < ActiveRecord::Migration[5.1]
  def change
    add_column :contents, :contact, :text
  end
end
