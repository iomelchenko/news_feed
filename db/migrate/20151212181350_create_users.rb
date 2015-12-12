class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string    :username
      t.string    :encrypted_password
      t.string    :api_key
      t.datetime  :api_key_expires_at
      t.timestamps null: false
      t.string    :role
    end
    add_index :users, :username, unique: true
    add_index :users, :api_key, unique: true
    add_index :users, :id, unique: true
  end
end
