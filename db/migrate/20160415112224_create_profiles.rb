class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :class_rank
      t.string :socioeconomic_status
      t.string :living_situation
      t.string :sexual_orientation
      t.integer :comfort_with_sexuality
      t.integer :age
      t.boolean :is_first_generation_college_student
      t.boolean :is_physically_disabled
      t.boolean :is_parent
      t.boolean :is_single_parent
      t.boolean :is_from_foster_care
      t.boolean :is_intercollegiate_athlete
      t.boolean :is_military
      t.boolean :is_out_of_state_student
      t.boolean :is_international_student
      t.boolean :is_transfer_student
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
