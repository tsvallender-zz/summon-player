class CreateJoinTableUsersChats < ActiveRecord::Migration[6.0]
  def change
    create_join_table :users, :chats do |t|
      t.index [:user_id, :chat_id]
      t.index [:chat_id, :user_id]
    end
  end
end
