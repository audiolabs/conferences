class ChangeDateFormatInEvents < ActiveRecord::Migration
  def up
   change_column :events, :precisdeadline, :datetime
   change_column :events, :fullpaperdeadline, :datetime
  end

  def down
   change_column :events, :precisdeadline, :date
   change_column :events, :fullpaperdeadline, :date
  end
end
