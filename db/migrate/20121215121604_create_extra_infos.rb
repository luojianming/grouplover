class CreateExtraInfos < ActiveRecord::Migration
  def change
    create_table :extra_infos do |t|
      t.string :vistors
      t.integer :user_id

      t.timestamps
    end
  end

end
