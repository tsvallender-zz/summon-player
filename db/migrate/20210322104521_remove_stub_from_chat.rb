class RemoveStubFromChat < ActiveRecord::Migration[6.0]
  def change
    remove_column :chats, :stub, :string
  end
end
