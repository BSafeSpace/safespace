class AddConversationIdToMutes < ActiveRecord::Migration[5.1]
  def change
    add_column :mutes, :conversation_id, :integer
  end
end
