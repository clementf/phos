class CreateAlarms < ActiveRecord::Migration[5.2]
  def change
    create_table :alarms do |t|
      t.string :days
      t.time :time, null: false
      t.boolean :active, null: false, default: true
      t.timestamps
    end
  end
end
