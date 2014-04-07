class AddNameLongColumnToEvents < ActiveRecord::Migration
  def change
    add_column :events, :nameLong, :string
  end
end
