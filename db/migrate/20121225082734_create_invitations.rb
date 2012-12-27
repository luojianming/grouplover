class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
      t.integer :initiate_group_id
      t.string :time
      t.string :location
      t.string :description
      t.string :status
      t.string :lover_style

      t.timestamps
    end
  end
end
