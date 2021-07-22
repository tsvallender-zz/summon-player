class RemoveTextFromAd < ActiveRecord::Migration[6.1]
  def change
    remove_column :ads, :text, :string
  end
end
