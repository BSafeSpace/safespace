class AddQuizIdToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :quiz_id, :integer
  end
end
