class CreateRecommendations < ActiveRecord::Migration
  def change
    create_table :recommendations do |t|
      t.string :reason
      t.text :additional_info
      t.boolean :opened
      t.integer :user_id
      t.integer :peer_counselor_id

      t.timestamps null: false
    end
  end
end
