class ParkingLot < ApplicationRecord
  scope :available_lots, -> { where('lots_available > ?', 0) }
  scope :sort_with_higher_availabiltiy,  -> { order(lots_available: :desc) }

  acts_as_mappable :lat_column_name => :latitude, :lng_column_name => :longitude

  validates :car_park_no, presence: true, allow_nil: false, allow_blank: false
  validates :latitude, presence: true, allow_nil: false, allow_blank: false, numericality: true
  validates :longitude, presence: true, allow_nil: false, allow_blank: false, numericality: true
  validates :total_lots, allow_nil: false, allow_blank: false, numericality: { only_integer: true }
  validates :lots_available, allow_nil: false, allow_blank: false, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end
