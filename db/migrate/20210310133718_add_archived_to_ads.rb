class AddArchivedToAds < ActiveRecord::Migration[6.0]
  def change
    add_column :ads, :archived, :boolean, :default => false
  end
end
