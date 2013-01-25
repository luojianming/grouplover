class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.boolean :sex
      t.string :birthday
      t.string :hometown
      t.string :school
      t.string :musical_instruments
      t.string :books
      t.string :sports
      t.string :music
      t.string :movie
      t.string :animation
      t.string :games
      t.string :telephone
      t.string :msn
      t.string :qq
      t.string :email
      t.integer :user_id
 
      t.timestamps
    end
  end
end
