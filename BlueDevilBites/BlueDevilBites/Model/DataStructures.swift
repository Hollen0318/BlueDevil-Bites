//
//  DataStructures.swift
//  BlueDevilBites
//
//  Created by Hollen Zhang on 11/6/23.
//

import Foundation
import SwiftUI

struct Res: Codable {
    var placeId: Int
    var isOpen: Bool
    var name: String
    var position: Position
    var location: String
    var phone: String
    var schedule: [ScheduleItem]
    var tags: [String]
    var ownerOperator: String?
    var paymentMethods: String?

    struct Position: Codable {
        var latitude: String
        var longitude: String
        var googleMap: String
    }

    struct ScheduleItem: Codable {
        var label: String
        var date: String
        var time: String
    }

    enum CodingKeys: String, CodingKey {
        case placeId = "place_id"
        case isOpen = "open"
        case name, position, location, phone, schedule, tags
        case ownerOperator = "ownerOperator"
        case paymentMethods = "paymentMethods"
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
