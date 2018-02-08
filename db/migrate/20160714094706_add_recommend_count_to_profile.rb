class AddRecommendCountToProfile < ActiveRecord::Migration[5.1]
  def change
    add_column :profiles, :recommend_count, :integer, default: 0
  end
end
