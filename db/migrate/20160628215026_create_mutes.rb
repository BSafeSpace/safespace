class CreateMutes < ActiveRecord::Migration
  def change
    create_table :mutes do |t|
      t.integer :muter_id
      t.integer :muted_id

      t.timestamps null: false
    end
  end
end
