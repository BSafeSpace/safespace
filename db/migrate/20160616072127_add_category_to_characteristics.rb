class AddCategoryToCharacteristics < ActiveRecord::Migration[5.1]
  def change
    add_column :characteristics, :category, :string
  end
end
