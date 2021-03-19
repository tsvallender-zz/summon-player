class RemoveToFromMessage < ActiveRecord::Migration[6.0]
  def change
    remove_column :messages, :to_id
  end
end
