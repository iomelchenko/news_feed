class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.integer    :rating
      t.integer    :target_id
      t.string     :target_type
      t.references :user
      t.timestamps null: false
    end
    add_index :ratings, :target_id
  end
end
