//
//  DataStructures.swift
//  BlueDevilBites
//
//  Created by Hollen Zhang on 11/6/23.
//

import Foundation
import SwiftUI

struct Res: Codable {
    var placeIdString: String
    var isOpenString: String // Changed from Bool to String
    var isOpen: Bool {
        return isOpenString.lowercased() == "true"
    }
    var name: String
    var position: Position
    var location: String
    var phone: String?
    var tags: [String]
    
    // Computed property to convert placeId to Int
    var placeId: Int? {
        return Int(placeIdString)
    }

    struct Position: Codable {
        var latitude: String
        var longitude: String
        var googleMap: String?
        
        enum CodingKeys: String, CodingKey {
            case latitude = "latitude"
            case longitude = "longitude"
            case googleMap = "google_map"
        }
    }

    enum CodingKeys: String, CodingKey {
        case placeIdString = "place_id"
        case isOpenString = "open" // Map to the correct JSON field
        case name, position, location, phone, tags
    }
}


struct ResData: Codable {
    var id: Int
}

struct CommentData: Codable {
    var username: String
    var content: String
    var score: Int
}
