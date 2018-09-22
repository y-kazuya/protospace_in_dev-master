class CreatePrototypesTags < ActiveRecord::Migration
  def change
    create_table :prototypes_tags do |t|
      t.references :prototype, index: true, foreign_key: true
      t.references :tag, index: true, foreign_key: true
    end
  end
end
