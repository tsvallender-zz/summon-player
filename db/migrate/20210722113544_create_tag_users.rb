class CreateTagUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :tag_users do |t|
      t.belongs_to :tag, null: false, foreign_key: true
      t.belongs_to :user, null: false, foreign_key: true

      t.timestamps
    end

    add_index :tag_users, [:tag_id, :user_id], unique: true
  end
end
