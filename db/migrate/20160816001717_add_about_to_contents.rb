class AddAboutToContents < ActiveRecord::Migration[5.1]
  def change
    add_column :contents, :about, :text
  end
end
