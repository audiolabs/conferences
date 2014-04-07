class AddHindexToEvents < ActiveRecord::Migration
  def change
    add_column :events, :hindex, :integer
  end
end
