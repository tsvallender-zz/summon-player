class AddCategoryToAds < ActiveRecord::Migration[6.0]
  def up
    execute <<-SQL
      CREATE TYPE ad_category AS ENUM('rpg', 'ccg', 'boardgame', 'wargame', 'traditional', 'larp');
    SQL
    add_column :ads, :category, :ad_category
  end

  def def down 
    remove_column :ads, :category
    execute <<-SQL
      DROP TYPE category;
    SQL
  end

end
