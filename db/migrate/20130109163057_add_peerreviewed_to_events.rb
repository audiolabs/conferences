class AddPeerreviewedToEvents < ActiveRecord::Migration
  def change
    add_column :events, :peerreviewed, :boolean
  end
end
