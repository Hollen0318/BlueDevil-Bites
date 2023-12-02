import SwiftUI
import PlaygroundSupport

let mockJSON = """
[
  {
    "open": "true",
    "name": "Bella Union",
    "tags": [
      "coffee",
      "dining",
      "mobile",
      "west_campus"
    ],
    "position": {
      "latitude": "35.9992010000",
      "longitude": "-78.9368560000",
      "google_map": "https://maps.google.com/?q=35.9992010000%2C-78.9368560000"
    },
    "place_id": "10003",
    "location": "McClendon Tower",
    "phone": ""
  },
  {
    "open": "true",
    "name": "McDonald's",
    "tags": [
      "bryan_center",
      "coffee",
      "dining",
      "mobile",
      "west_campus"
    ],
    "position": {
      "latitude": "36.0010100000",
      "longitude": "-78.9407900000",
      "google_map": "https://maps.google.com/?q=36.0010100000%2C-78.9407900000"
    },
    "place_id": "10018",
    "location": "Bryan Center",
    "phone": ""
  },
  {
    "open": "true",
    "name": "Saladelia Cafe at Perkins",
    "tags": [
      "coffee",
      "dining",
      "west_campus"
    ],
    "position": {
      "latitude": "36.0021860000",
      "longitude": "-78.9382780000",
      "google_map": "https://maps.google.com/?q=36.0021860000%2C-78.9382780000"
    },
    "place_id": "10022",
    "location": "Bostock Library",
    "phone": ""
  },
  {
    "open": "false",
    "name": "Zweli's Cafe at Duke Divinity",
    "tags": [
      "coffee",
      "dining",
      "west_campus"
    ],
    "position": {
      "latitude": "36.0019559771",
      "longitude": "-78.9395009901",
      "google_map": "https://maps.google.com/?q=36.0019559771%2C-78.9395009901"
    },
    "place_id": "10024",
    "location": "Divinity School",
    "phone": ""
  },
  {
    "open": "false",
    "name": "Legal Grounds at Duke Law",
    "tags": [
      "dining",
      "west_campus"
    ],
    "position": {
      "latitude": "35.9999016293",
      "longitude": "-78.9455183739",
      "google_map": "https://maps.google.com/?q=35.9999016293%2C-78.9455183739"
    },
    "place_id": "10025",
    "location": "Law School",
    "phone": ""
  },
  {
    "open": "false",
    "name": "Saladelia Cafe at Sanford",
    "tags": [
      "coffee",
      "dining",
      "west_campus"
    ],
    "position": {
      "latitude": "35.9993937527",
      "longitude": "-78.9439233063",
      "google_map": "https://maps.google.com/?q=35.9993937527%2C-78.9439233063"
    },
    "place_id": "10026",
    "location": "Sanford School of Public Policy",
    "phone": ""
  },
  {
    "open": "true",
    "name": "Pitchfork's",
    "tags": [
      "dining",
      "west_campus"
    ],
    "position": {
      "latitude": "35.9989806122",
      "longitude": "-78.9380255906",
      "google_map": "https://maps.google.com/?q=35.9989806122%2C-78.9380255906"
    },
    "place_id": "10029",
    "location": "McClendon Tower",
    "phone": ""
  },
  {
    "open": "false",
    "name": "Twinnie's",
    "tags": [
      "coffee",
      "dining",
      "west_campus"
    ],
    "position": {
      "latitude": "36.0033193507",
      "longitude": "-78.9397538010",
      "google_map": "https://maps.google.com/?q=36.0033193507%2C-78.9397538010"
    },
    "place_id": "10031",
    "location": "CIEMAS",
    "phone": ""
  },
  {
    "open": "false",
    "name": "Bseisu Coffee Bar",
    "tags": [
      "dining",
      "west_campus"
    ],
    "position": {
      "latitude": "36.0033153000",
      "longitude": "-78.9384756000",
      "google_map": "https://maps.google.com/?q=36.0033153000%2C-78.9384756000"
    },
    "place_id": "2",
    "location": "Wilkinson Building.",
    "phone": ""
  },
  {
    "open": "false",
    "name": "Panera",
    "tags": [
      "brodhead_center",
      "coffee",
      "dining",
      "dining",
      "mobile",
      "west_campus"
    ],
    "position": {
      "latitude": "36.0005840000",
      "longitude": "-78.9394840000",
      "google_map": "https://maps.google.com/?q=36.0005840000%2C-78.9394840000"
    },
    "place_id": "21055",
    "location": "Brodhead Center",
    "phone": "919 660-3932"
  },
  {
    "open": "false",
    "name": "Red Mango Cafe",
    "tags": [
      "dining",
      "west_campus"
    ],
    "position": {
      "latitude": "35.9969319027",
      "longitude": "-78.9406134491",
      "google_map": "https://maps.google.com/?q=35.9969319027%2C-78.9406134491"
    },
    "place_id": "21156",
    "location": "Wilson Recreation Center",
    "phone": ""
  },
  {
    "open": "true",
    "name": "The Devil's Krafthouse",
    "tags": [
      "brodhead_center",
      "dining",
      "west_campus"
    ],
    "position": {
      "latitude": "36.0007100000",
      "longitude": "-78.9397130000",
      "google_map": "https://maps.google.com/?q=36.0007100000%2C-78.9397130000"
    },
    "place_id": "21554",
    "location": "Brodhead Center",
    "phone": "919-681-8888"
  },
  {
    "open": "false",
    "name": "The Skillet ",
    "tags": [
      "brodhead_center",
      "dining",
      "mobile",
      "west_campus"
    ],
    "position": {
      "latitude": "36.0008010000",
      "longitude": "-78.9396510000",
      "google_map": "https://maps.google.com/?q=36.0008010000%2C-78.9396510000"
    },
    "place_id": "21574",
    "location": "Brodhead Center",
    "phone": ""
  },
  {
    "open": "false",
    "name": "Ginger & Soy ",
    "tags": [
      "brodhead_center",
      "dining",
      "mobile",
      "west_campus"
    ],
    "position": {
      "latitude": "36.0009270000",
      "longitude": "-78.9392170000",
      "google_map": "https://maps.google.com/?q=36.0009270000%2C-78.9392170000"
    },
    "place_id": "21594",
    "location": "Brodhead Center",
    "phone": ""
  },
  {
    "open": "false",
    "name": "Gyotaku",
    "tags": [
      "brodhead_center",
      "dining",
      "mobile",
      "west_campus"
    ],
    "position": {
      "latitude": "36.0009840000",
      "longitude": "-78.9393690000",
      "google_map": "https://maps.google.com/?q=36.0009840000%2C-78.9393690000"
    },
    "place_id": "21614",
    "location": "Brodhead Center",
    "phone": ""
  },
  {
    "open": "false",
    "name": "Tandoor",
    "tags": [
      "brodhead_center",
      "dining",
      "west_campus"
    ],
    "position": {
      "latitude": "36.0009781565",
      "longitude": "-78.9394928307",
      "google_map": "https://maps.google.com/?q=36.0009781565%2C-78.9394928307"
    },
    "place_id": "21634",
    "location": "Brodhead Center",
    "phone": ""
  },
  {
    "open": "true",
    "name": "Cafe",
    "tags": [
      "brodhead_center",
      "coffee",
      "dining",
      "west_campus"
    ],
    "position": {
      "latitude": "36.0005950000",
      "longitude": "-78.9392700000",
      "google_map": "https://maps.google.com/?q=36.0005950000%2C-78.9392700000"
    },
    "place_id": "21635",
    "location": "Brodhead Center",
    "phone": ""
  },
  {
    "open": "false",
    "name": "The Commons",
    "tags": [
      "brodhead_center",
      "coffee",
      "dining",
      "west_campus"
    ],
    "position": {
      "latitude": "36.0006070000",
      "longitude": "-78.9394070000",
      "google_map": "https://maps.google.com/?q=36.0006070000%2C-78.9394070000"
    },
    "place_id": "21636",
    "location": "Brodhead Center",
    "phone": ""
  },
  {
    "open": "false",
    "name": "Il Forno",
    "tags": [
      "brodhead_center",
      "dining",
      "mobile",
      "west_campus"
    ],
    "position": {
      "latitude": "36.0006790000",
      "longitude": "-78.9394230000",
      "google_map": "https://maps.google.com/?q=36.0006790000%2C-78.9394230000"
    },
    "place_id": "21638",
    "location": "Brodhead Center",
    "phone": ""
  },
  {
    "open": "false",
    "name": "Farmstead",
    "tags": [
      "brodhead_center",
      "dining",
      "west_campus"
    ],
    "position": {
      "latitude": "36.0007930000",
      "longitude": "-78.9392320000",
      "google_map": "https://maps.google.com/?q=36.0007930000%2C-78.9392320000"
    },
    "place_id": "21639",
    "location": "Brodhead Center",
    "phone": ""
  },
  {
    "open": "false",
    "name": "Sprout",
    "tags": [
      "brodhead_center",
      "dining",
      "west_campus"
    ],
    "position": {
      "latitude": "36.0008470000",
      "longitude": "-78.9393080000",
      "google_map": "https://maps.google.com/?q=36.0008470000%2C-78.9393080000"
    },
    "place_id": "21640",
    "location": "Brodhead Center",
    "phone": ""
  },
  {
    "open": "false",
    "name": "JB's Roasts and Chops",
    "tags": [
      "brodhead_center",
      "dining",
      "mobile",
      "west_campus"
    ],
    "position": {
      "latitude": "36.0009380000",
      "longitude": "-78.9395600000",
      "google_map": "https://maps.google.com/?q=36.0009380000%2C-78.9395600000"
    },
    "place_id": "21641",
    "location": "Brodhead Center",
    "phone": ""
  },
  {
    "open": "false",
    "name": "Beyu Blue",
    "tags": [
      "bryan_center",
      "coffee",
      "dining",
      "mobile",
      "west_campus"
    ],
    "position": {
      "latitude": "36.0008600000",
      "longitude": "-78.9406000000",
      "google_map": "https://maps.google.com/?q=36.0008600000%2C-78.9406000000"
    },
    "place_id": "21674",
    "location": "Bryan Center",
    "phone": ""
  },
  {
    "open": "false",
    "name": "Sazon",
    "tags": [
      "brodhead_center",
      "dining",
      "mobile",
      "west_campus"
    ],
    "position": {
      "latitude": "36.0006070000",
      "longitude": "-78.9393310000",
      "google_map": "https://maps.google.com/?q=36.0006070000%2C-78.9393310000"
    },
    "place_id": "21694",
    "location": "Brodhead Center",
    "phone": ""
  },
  {
    "open": "true",
    "name": "Gothic Grill",
    "tags": [
      "bryan_center",
      "dining",
      "dinner",
      "lunch",
      "mobile",
      "west_campus"
    ],
    "position": {
      "latitude": "36.0013200000",
      "longitude": "-78.9409200000",
      "google_map": "https://maps.google.com/?q=36.0013200000%2C-78.9409200000"
    },
    "place_id": "3",
    "location": "Bryan Center",
    "phone": ""
  }
]
""".data(using: .utf8)!

// Playground testing
let placesDataModel = PlacesDataModel()

// Simulating a file URL since playground cannot access the actual file system
let tempDirectoryURL = URL(fileURLWithPath: NSTemporaryDirectory())
let tempFileURL = tempDirectoryURL.appendingPathComponent("datamodel.json")

// Write the mock JSON to the temp file
try mockJSON.write(to: tempFileURL)

// Use the load method to simulate loading the downloaded data
placesDataModel.load(dataModelFileURL: tempFileURL)

for place in placesDataModel.places {
    print(place.id)
    print(place.isOpen)
    print(place.name)
    print(place.tags)
    print(place.position)
    print(place.place_id)
    print(place.location)
    print(place.phone!)
    print("")
}

// Cleanup after test
try FileManager.default.removeItem(at: tempFileURL)
