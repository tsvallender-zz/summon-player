class AddStubToCategory < ActiveRecord::Migration[6.0]
  def change
    add_column :categories, :stub, :string
  end
end
