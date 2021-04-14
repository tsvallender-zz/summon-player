class AddLastReadToChatsUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :chats_users, :last_read, :datetime, null: false, :default => Time.current
  end
end
