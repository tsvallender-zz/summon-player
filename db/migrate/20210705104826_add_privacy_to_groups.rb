class AddPrivacyToGroups < ActiveRecord::Migration[6.1]
  def up
    execute <<-SQL
      CREATE TYPE group_privacy AS ENUM ('open', 'request', 'invite');
    SQL
    add_column :groups, :privacy, :group_privacy, :default => 'open'
  end

  def down
    remove_column :groups, :privacy
    execute <<-SQL
      DROP TYPE group_privacy;
    SQL
  end
end
