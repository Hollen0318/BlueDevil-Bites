//
//  RestaurantList.swift
//  BlueDevilBites
//
//  Created by Hollen Zhang on 11/14/23.
//

import SwiftUI

struct RestaurantList: View {
    @EnvironmentObject var resDataModel: ResDataModel

    var body: some View {
        NavigationView {
            List {
                ForEach(resDataModel.restaurants, id: \.placeId) { restaurant in
                    VStack(alignment: .leading) {
                        Text(restaurant.name)
                            .font(.headline)
                        Text("Status: \(restaurant.isOpen ? "Open" : "Closed")")
                        Text("Location: \(restaurant.location)")
                        Text("Phone: \(restaurant.phone!)")
                        Text("Place ID: \(restaurant.placeIdString)")
                        Text("Latitude: \(restaurant.position.latitude)")
                        Text("Longitude: \(restaurant.position.longitude)")
                        Text("GoogleMap: \(restaurant.position.googleMap ?? "GoogleMap Address Not available")")
                        // Display tags
                        if !restaurant.tags.isEmpty {
                            Text("Tags: ")
                            ForEach(restaurant.tags, id: \.self) { tag in
                                Text(tag)
                                    .padding(4)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color.blue, lineWidth: 1)
                                    )
                            }
                        } else {
                            Text("No Tags Available")
                        }
                        // Displaying comments
                        if let comments = resDataModel.comments[restaurant.placeId!] {
                            ForEach(comments, id: \.username) { comment in
                                Text("\(comment.username): \(comment.content)")
                            }
                        } else {
                            Text("No Comments Available Yet")
                        }
                    }
                }
            }
            .navigationTitle("BlueDevil Bites")
        }
    }
}
