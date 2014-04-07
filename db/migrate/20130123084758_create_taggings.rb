class CreateTaggings < ActiveRecord::Migration
  def change
    create_table :taggings do |t|
      t.belongs_to :tag
      t.belongs_to :event

      t.timestamps
    end
    add_index :taggings, :tag_id
    add_index :taggings, :event_id
  end
end
