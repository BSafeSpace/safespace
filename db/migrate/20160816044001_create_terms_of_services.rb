class CreateTermsOfServices < ActiveRecord::Migration
  def change
    create_table :terms_of_services do |t|

      t.timestamps null: false
    end
  end
end
