class CreateLotAvailabilities < ActiveRecord::Migration[6.0]
  def change
    create_table :lot_availabilities do |t|
      t.references :parking_lot, null: false, foreign_key: true
      t.string :address
      t.decimal :latitude, precision: 18, scale: 14
      t.decimal :longitude, precision: 18, scale: 14
      t.integer :total_lots, default: 0
      t.integer :lots_available, default: 0

      t.timestamps
    end
    add_index :lot_availabilities, :total_lots
    add_index :lot_availabilities, :lots_available
  end
end
