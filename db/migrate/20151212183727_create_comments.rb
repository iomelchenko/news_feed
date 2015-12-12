class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text       :comment
      t.references :news
      t.references :user
      t.timestamps null: false
    end
    add_index :comments, :id, unique: true
    add_index :comments, :news_id
    add_index :comments, :user_id
  end
end
