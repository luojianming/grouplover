class RenameNicknameToName < ActiveRecord::Migration
  change_table :users do |t|
    t.rename :nickname, :name
  end
end
