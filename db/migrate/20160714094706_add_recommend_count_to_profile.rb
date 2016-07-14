class AddRecommendCountToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :recommend_count, :integer, default: 0
  end
end
