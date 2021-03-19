class CreateJoinTableUserChat < ActiveRecord::Migration[6.0]
  def change
    create_join_table :users, :chats do |t|
      t.index :user_id
      t.index :chat_id
    end
  end
end
