class CreateContents < ActiveRecord::Migration
  def change
    create_table :contents do |t|
      t.text :terms_of_service
      t.text :slide_one
      t.text :slide_two
      t.text :slide_three
      t.text :slide_four

      t.timestamps null: false
    end
  end
end
