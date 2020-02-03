#### System Requirements:
  Ruby v2.7.0
  Rails v6.0.2.1
  MySQL v8.0.19
  OS: Ubuntu/MacOS

#### App Setup:

  **Clone Repo:**
  
  `$> git clone https://github.com/ranganayakulu/wego_parking.git`

  **Change DIR to Project Folder:**

  `$> cd wego_parking`

  **Create the database and migrate:**

  `$> rails db:prepare`

  **Rake Task(s) to setup up default data from Singapore Govt. DB source:**

    `$> rails parking_lots:seed_parking_lots`               # Loads Parking Lots from Singapore Govt
    `$> rails parking_lots:seed_parking_lots_availability`  # Loads Parking Lots Availability from Singapore Govt 


  **Run server:**

  `$> rails s`

#### RESTful APIs:

  Resource URL:
  
    http://localhost:3000/carparks/nearest

  Parameters: 
  
  | Name | Requred | Type | Description | Default | Example |
  |------|-------|------|-------|------|-------|
  | `latitude`| required | float | Latitude of the current location of the user | NA | latitude=1.3365166 |
  | `longitude`| required | float | Longitude of the current location of the user | NA | longitude=103.7766082 |
  | `page`| optional | integer | Pagination parameter  - offset | 1 | page=1 |
  | `per_page`| optional | integer | Pagination parameter, No of records per request | 20 | per_page=1 |
  | `with_in`| optional | integer | Miles with in to be searched | 2 | with_in=5 |
  


  Example Request:

  CURL -X GET -H "Accept: application/json" -H "Content-Type: application/json"  'http://localhost:4000/carparks/nearest?page=1&per_page=10&with_in=3&latitude=1.3365166&longitude=103.7766082'


  Example Response:

  ```json
  {
    "count": 190,
    "carparks": [
        {
            "address": "BLK 219/233 PETIR ROAD",
            "latitude": "1.3755313767854",
            "longitude": "103.7722579352748",
            "total_lots": 752,
            "lots_available": 629
        },
        {
            "address": "BLK 289H BUKIT BATOK STREET 25",
            "latitude": "1.34450628322565",
            "longitude": "103.7599177708396",
            "total_lots": 1214,
            "lots_available": 566
        },
        {
            "address": "BLK 28 DOVER CRESCENT",
            "latitude": "1.30473889283041",
            "longitude": "103.781674489325",
            "total_lots": 696,
            "lots_available": 548
        },
        {
            "address": "BLK 287E JURONG EAST STREET 21",
            "latitude": "1.33753721991719",
            "longitude": "103.7441050519854",
            "total_lots": 595,
            "lots_available": 541
        },
        {
            "address": "BLK 395A BUKIT BATOK WEST AVE 5",
            "latitude": "1.36583063528229",
            "longitude": "103.7517718286718",
            "total_lots": 1200,
            "lots_available": 541
        },
        {
            "address": "BLK 407-426 BUKIT BATOK WEST AVE 2/4",
            "latitude": "1.36302119257396",
            "longitude": "103.7455653333897",
            "total_lots": 750,
            "lots_available": 536
        },
        {
            "address": "BLK 201/211 BUKIT BATOK STREET 21",
            "latitude": "1.34696157183413",
            "longitude": "103.7494702726217",
            "total_lots": 773,
            "lots_available": 535
        },
        {
            "address": "BLK 601-613 CLEMENTI WEST STREET 1",
            "latitude": "1.30455943796697",
            "longitude": "103.7668576180022",
            "total_lots": 805,
            "lots_available": 515
        },
        {
            "address": "BLK 18 HOLLAND DRIVE",
            "latitude": "1.31159320403215",
            "longitude": "103.7920155544578",
            "total_lots": 607,
            "lots_available": 468
        },
        {
            "address": "BLK 403/408 PANDAN GARDENS",
            "latitude": "1.31935361778841",
            "longitude": "103.7491754010767",
            "total_lots": 602,
            "lots_available": 462
        }
    ]
}
```
