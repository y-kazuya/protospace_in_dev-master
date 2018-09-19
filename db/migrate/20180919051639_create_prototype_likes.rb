class CreatePrototypeLikes < ActiveRecord::Migration
  def change
    create_table :prototype_likes do |t|
      t.references :prototype, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
    add_index :prototype_likes, [:prototype_id, :user_id], unique: true
  end
end
