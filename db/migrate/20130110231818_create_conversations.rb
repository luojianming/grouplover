class CreateConversations < ActiveRecord::Migration
  def change
    create_table :conversations do |t|

      t.references :conversationer, :polymorphic => true 
      t.timestamps
    end
  end
end
