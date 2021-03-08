class CreateAdTags < ActiveRecord::Migration[6.0]
  def change
    create_table :ad_tags do |t|
      t.integer :ad_id
      t.integer :tag_id

      t.timestamps
    end

    add_index :ad_tags, :ad_id
    add_index :ad_tags, :tag_id
    add_index :ad_tags, [:ad_id, :tag_id], unique: true
  end
end
