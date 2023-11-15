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

struct ResData: Codable {
    var id: Int
}

struct CommentData: Codable {
    var username: String
    var content: String
    var score: Int
}
