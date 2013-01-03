class AddNumberToPhoto < ActiveRecord::Migration
  def change
    add_column :photos, :number, :integer
  end
end
