class RenameNameToNickname < ActiveRecord::Migration
  change_table :users do |t|
    t.rename :name, :nickname
  end
end
