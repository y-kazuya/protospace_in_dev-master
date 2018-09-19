class DestroyPrototypeLike < ActiveRecord::Migration
  def change
    drop_table :prototype_likes
  end
end
