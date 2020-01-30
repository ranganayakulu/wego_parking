class CreateParkingLots < ActiveRecord::Migration[6.0]
  def change
    create_table :parking_lots do |t|
      t.string :car_park_no
      t.string :address
      t.decimal :latitude, precision: 18, scale: 14
      t.decimal :longitude, precision: 18, scale: 14
      t.string :car_park_type
      t.string :type_of_parking_system
      t.string :short_term_parking
      t.string :free_parking
      t.string :night_parking
      t.integer :car_park_decks, default: 0
      t.decimal :gantry_height, precision: 3, scale: 2, default: 0.00
      t.string :car_park_basement
      t.integer :total_lots, default: 0
      t.integer :lots_available, default: 0


      t.timestamps
    end
    add_index :parking_lots, :car_park_no
    add_index :parking_lots, :latitude
    add_index :parking_lots, :longitude
    add_index :parking_lots, :total_lots
    add_index :parking_lots, :lots_available
  end
end
