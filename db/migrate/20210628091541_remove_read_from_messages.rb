class RemoveReadFromMessages < ActiveRecord::Migration[6.1]
  def change
    remove_column :messages, :read, :boolean
  end
end
