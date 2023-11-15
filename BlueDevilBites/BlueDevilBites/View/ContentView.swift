//
//  ContentView.swift
//  BlueDevilBites
//
//  Created by Hollen Zhang on 10/10/23.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var dataModel: ResDataModel

    var body: some View {
        NavigationView {
            List {
                ForEach(dataModel.restaurants, id: \.placeId) { restaurant in
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
                        // Displaying comments
                        if let comments = dataModel.comments[restaurant.placeId!] {
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
