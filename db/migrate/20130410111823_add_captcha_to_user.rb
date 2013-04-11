class AddCaptchaToUser < ActiveRecord::Migration
  def change
    add_column :users, :captcha, :string
  end
end
