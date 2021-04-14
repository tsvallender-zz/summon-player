class CreateChatUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :chat_users do |t|
      t.belongs_to :chat, null: false, foreign_key: true
      t.belongs_to :user, null: false, foreign_key: true
      t.datetime :last_read, null: false, :default => Time.current

      t.timestamps
    end
  end
end
