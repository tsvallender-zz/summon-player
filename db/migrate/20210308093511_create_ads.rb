class CreateAds < ActiveRecord::Migration[6.0]
  def change
    create_table :ads do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title
      t.string :text

      t.timestamps
    end
    add_index :ads, [:user_id, :created_at]
  end
end
