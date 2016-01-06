class DeviseTokenAuthAddTokenInfoToUsers < ActiveRecord::Migration
  def change
    change_table(:users) do |t|
      ## unique oauth id
      t.string :provider
      t.string :uid, :null => false, :default => ""

      ## Tokens
      t.text :tokens
    end

    add_index :users, :uid,                  :unique => true

    User.reset_column_information
    User.all.each do |user|
      user.uid = user.login
      user.save
    end
  end
end
