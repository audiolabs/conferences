class RemoveEventIdFromTags < ActiveRecord::Migration
  def up
    remove_column :tags, :event_id
  end
end
