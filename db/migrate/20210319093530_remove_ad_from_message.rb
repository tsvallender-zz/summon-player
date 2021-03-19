class RemoveAdFromMessage < ActiveRecord::Migration[6.0]
  def change
    remove_column :messages, :ad_id, :bigint
  end
end
