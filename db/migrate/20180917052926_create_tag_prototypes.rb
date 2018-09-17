class CreateTagPrototypes < ActiveRecord::Migration
  def change
    create_table :tag_prototypes do |t|
      t.integer :prototype_id
      t.integer :tag_id
      t.timestamps null: false
    end
  end
end
