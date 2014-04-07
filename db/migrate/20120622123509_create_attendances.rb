class CreateAttendances < ActiveRecord::Migration
  def change
    create_table :attendances do |t|
      t.string :name
      t.boolean :accepted
      t.boolean :submitted
      t.boolean :planningtosubmit
      t.boolean :attending
      t.references :event
      t.text :comments

      t.timestamps
    end
    add_index :attendances, :event_id  
  end
end
