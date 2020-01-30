require "csv"
# parking lots - namespace
# seed parking lots - task1
# seed parking lots availability - task2
namespace :parking_lots do
  desc 'Load Parking Lots from Singapore Govt. Database | CSV File'
  task :seed_parking_lots => :environment do |task, args|
    parking_lot_data_file = Rails.root.join('datasets', 'hdb-carpark-information.csv')
    CSV.foreach(parking_lot_data_file, headers: true, header_converters: :symbol) do |row|
      # Since the csv file consists of duplicate entries
      # skip those entries
      next if ParkingLot.where(car_park_no: row[:car_park_no]).present?

      parking_lot = ParkingLot.new
      parking_lot.car_park_no = row[:car_park_no]
      parking_lot.address = row[:address]

      # Convert coordinates
      coordinates = convert_coordinates(row[:x_coord], row[:y_coord])
      parking_lot.latitude = coordinates['latitude']
      parking_lot.longitude = coordinates['longitude']
      parking_lot.car_park_type = row[:car_park_type]
      parking_lot.type_of_parking_system = row[:type_of_parking_system]
      parking_lot.short_term_parking = row[:short_term_parking]
      parking_lot.free_parking = row[:free_parking]
      parking_lot.night_parking = row[:night_parking]
      parking_lot.car_park_decks = row[:car_park_decks]
      parking_lot.gantry_height = row[:gantry_height].to_f
      parking_lot.car_park_basement = row[:car_park_basement]
      parking_lot.save
    end
  end
  
  desc 'Load Parking Lots Availability from Singapore Govt. Database RESTful API'
  task :seed_parking_lots_availability => :environment do |task, args|
    status, response = update_lots_availability
    if status
      lot_availabilities = response['items'][0]['carpark_data']
      lot_availabilities.each do |lot_availability|
        parking_lot = ParkingLot.find_by(car_park_no: lot_availability['carpark_number'])
        
        next unless parking_lot.present?
        
        parking_lot.total_lots = lot_availability['carpark_info'].inject(0) { |sum, hash| sum + hash['total_lots'].to_i }
        parking_lot.lots_available = lot_availability['carpark_info'].inject(0) { |sum, hash| sum + hash['lots_available'].to_i }
        parking_lot.save
      end
    else
      puts response[:error][:message] + "\n" + 
        'API Returned ' + response[:error][:response_code] + ' code'
    end
  end

  # Gets latest information from Govt. DB
  def update_lots_availability
    response = Typhoeus.get("https://api.data.gov.sg/v1/transport/carpark-availability",
                            headers: http_headers)
    if response.code == 200
      status, data = true, JSON.parse(response.response_body)
    else
      status, data = false, {error: {message: 'API end point failed', response_code: response.code }}
    end
    [status, data]
  end

  def convert_coordinates(x_coord, y_coord)
    response = Typhoeus.get("https://developers.onemap.sg/commonapi/convert/3414to4326?X=#{x_coord}&Y=#{y_coord}",
                            headers: http_headers)
    JSON.parse(response.response_body)
  end

  def http_headers
    { "Accept" => "application/json", "Content-Type" => "application/json"}
  end
end
