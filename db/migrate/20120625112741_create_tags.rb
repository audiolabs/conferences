class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :name
      t.references :event

      t.timestamps
    end
    add_index :tags, :event_id
  end
end
