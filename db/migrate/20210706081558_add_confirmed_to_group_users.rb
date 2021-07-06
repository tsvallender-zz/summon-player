class AddConfirmedToGroupUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :group_users, :confirmed, :boolean, :default => false
  end
end
