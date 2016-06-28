class AddConversationIdToMutes < ActiveRecord::Migration
  def change
    add_column :mutes, :conversation_id, :integer
  end
end
