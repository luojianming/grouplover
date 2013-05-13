class ChangeColumnsInFeed < ActiveRecord::Migration
  change_table :feeds do |t|
    t.rename :model_name, :feedable_type
    t.rename :item_id, :feedable_id
  end
end
