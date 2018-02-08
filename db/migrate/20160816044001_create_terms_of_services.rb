class CreateTermsOfServices < ActiveRecord::Migration[5.1]
  def change
    create_table :terms_of_services do |t|

      t.timestamps null: false
    end
  end
end
