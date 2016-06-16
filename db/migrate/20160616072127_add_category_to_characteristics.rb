class AddCategoryToCharacteristics < ActiveRecord::Migration
  def change
    add_column :characteristics, :category, :string
  end
end
