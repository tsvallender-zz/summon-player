class CreateMessages < ActiveRecord::Migration[6.0]
  def change
    create_table :messages do |t|
      t.text :text
      t.integer :from_id
      t.integer :to_id

      t.timestamps
    end

    add_index :messages, :from_id
    add_index :messages, :to_id
  end
end
