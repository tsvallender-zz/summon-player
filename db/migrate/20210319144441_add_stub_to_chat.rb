class AddStubToChat < ActiveRecord::Migration[6.0]
  def change
    add_column :chats, :stub, :string
  end
end
