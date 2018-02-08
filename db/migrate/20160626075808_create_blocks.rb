class CreateBlocks < ActiveRecord::Migration[5.1]
  def change
    create_table :blocks do |t|

      t.timestamps null: false
    end
  end
end
