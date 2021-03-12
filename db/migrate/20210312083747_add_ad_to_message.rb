class AddAdToMessage < ActiveRecord::Migration[6.0]
  def change
    add_reference :messages, :ad, null: true, foreign_key: true, :index => true, :default => nil
  end
end
