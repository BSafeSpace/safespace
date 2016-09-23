class CreateJoinTableCharacteristicProfile < ActiveRecord::Migration
  def change
    create_join_table :characteristics, :profiles do |t|
      # t.index [:characteristic_id, :profile_id]
      # t.index [:profile_id, :characteristic_id]
    end
  end
end
