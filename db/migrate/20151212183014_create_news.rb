class CreateNews < ActiveRecord::Migration
  def change
    create_table :news do |t|
      t.string     :title
      t.text       :body
      t.string     :state
      t.references :user
      t.timestamps null: false
    end
    add_index :news, :id, unique: true
    add_index :news, :user_id
  end
end
