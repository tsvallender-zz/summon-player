class AddAdIdToMessage < ActiveRecord::Migration[6.0]
  def change
    add_column :messages, :ad_id, :bigint, :default => nil
  end
end
