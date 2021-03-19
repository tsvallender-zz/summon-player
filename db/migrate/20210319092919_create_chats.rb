class CreateChats < ActiveRecord::Migration[6.0]
  def change
    create_table :chats do |t|
      t.references :subject, polymorphic: true, null: true, :default => nil

      t.timestamps
    end
  end
end
