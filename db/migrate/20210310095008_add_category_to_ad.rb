class AddCategoryToAd < ActiveRecord::Migration[6.0]
  def change
    add_reference :ads, :category, null: false, foreign_key: true
  end
end
