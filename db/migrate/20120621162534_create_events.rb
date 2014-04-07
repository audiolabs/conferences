class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :name
      t.string :conferenceurl
      t.string :callforpapersurl
      t.boolean :precisdeadline_tba
      t.boolean :fullpaperdeadline_tba
      t.boolean :peerreviewed
      t.date :eventstart
      t.date :eventend
      t.date :precisdeadline
      t.date :fullpaperdeadline
      t.string :city
      t.string :country
      t.float :latitude
      t.float :longitude
      t.text :comments
      t.timestamps
    end
  end
end
