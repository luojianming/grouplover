class AddBasicInfoToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :name, :string
    add_column :profiles, :sex, :boolean
    add_column :profiles, :hometown, :string
    add_column :profiles, :location, :string
    add_column :profiles, :status, :string
    add_column :profiles, :avatar, :string
    add_column :profiles, :hobby, :string
    add_column :profiles, :style, :string
    add_column :profiles, :lover_style, :string
    add_column :profiles, :description, :string
  end
end
