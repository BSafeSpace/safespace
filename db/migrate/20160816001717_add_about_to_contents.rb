class AddAboutToContents < ActiveRecord::Migration
  def change
    add_column :contents, :about, :text
  end
end
