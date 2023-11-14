//
//  DataStructures.swift
//  BlueDevilBites
//
//  Created by Hollen Zhang on 11/6/23.
//

import Foundation
import SwiftUI

// Define a struct that represents the data model for the server response
struct Place: Codable, Identifiable {
    var id: Int // Explicitly declare the id property
    var isOpen: Bool
    var name: String
    var tags: [String]
    var position: Position
    var place_id: String
    var location: String
    var phone: String?
//    Right now we want to store the images into the asset
//    var picture: String?
    
//    var image: UIImage? {
//        guard let pictureName = picture else { return nil }
//        guard let base64String = getProcessedBase64ImageString(named: pictureName) else { return nil }
//        guard let imageData = Data(base64Encoded: base64String) else { return nil }
//        return UIImage(data: imageData)
//    }
    
    enum CodingKeys: String, CodingKey {
        case isOpen = "open"
        case name
        case tags
        case position
        case place_id
        case location
        case phone
    }
    
    struct Position: Codable {
        var latitude: String
        var longitude: String
        var googleMap: URL
        
        enum CodingKeys: String, CodingKey {
            case latitude
            case longitude
            case googleMap = "google_map"
        }
    }
    
    // Custom initializer for decoding
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = 0 // or some other default value
        let isOpenString = try container.decode(String.self, forKey: .isOpen)
        isOpen = (isOpenString as NSString).boolValue // Using NSString conversion
        name = try container.decode(String.self, forKey: .name)
        tags = try container.decode([String].self, forKey: .tags)
        position = try container.decode(Position.self, forKey: .position)
        place_id = try container.decode(String.self, forKey: .place_id)
        location = try container.decode(String.self, forKey: .location)
        phone = try container.decodeIfPresent(String.self, forKey: .phone)
    }
    
    // Implement Encodable conformance
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(isOpen ? "true" : "false", forKey: .isOpen) // encode isOpen as a String
        try container.encode(name, forKey: .name)
        try container.encode(tags, forKey: .tags)
        try container.encode(position, forKey: .position)
        try container.encode(place_id, forKey: .place_id)
        try container.encode(location, forKey: .location)
        try container.encodeIfPresent(phone, forKey: .phone)
    }
}

struct Comment: Codable, Identifiable {
    let id: Int
    let restaurantID: Int
    var content: String
    var score: Int
    let time: Date

    enum CodingKeys: String, CodingKey {
        case id = "Comment_ID"
        case restaurantID = "Restaurant_ID"
        case content = "Comment_Content"
        case score = "Comment_Score"
        case time = "Comment_Time"
    }

    // Ensure the score remains within the 1...5 range
    init(id: Int, restaurantID: Int, content: String, score: Int, time: Date) {
        self.id = id
        self.restaurantID = restaurantID
        self.content = content
        self.score = score >= 1 && score <= 5 ? score : 1
        self.time = time
    }
}
