class CreatePrototypeLikes < ActiveRecord::Migration
  def change
    create_table :prototype_likes do |t|
      t.integer :prototype_id
      t.integer :user_id
      t.timestamps null: false
    end
  end
end
