class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :photo
      t.string :oauthtoken
      t.string :password_digest
      t.string :oauthrefresh
      t.string :provider
      t.string :uid

      t.timestamps
    end
  end
end
