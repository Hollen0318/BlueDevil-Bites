//
//  ContentView.swift
//  BlueDevilBites
//
//  Created by Hollen Zhang on 10/10/23.
//

import SwiftUI
import CoreLocation

struct ContentView: View {
    @EnvironmentObject var dataModel: ResDataModel
    @State private var userLocation = CLLocationCoordinate2D()
    // You will have to implement location fetching and handle permissions

    var body: some View {
        ZStack {
            Image("BlueDevilBitesImage")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

            VStack {
                Spacer()
                
                // Search bar button
                Button(action: {
                    // Action to navigate to the search view
                }) {
                    HStack {
                        Image(systemName: "magnifyingglass")
                        Text("Search")
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 2)
                }
                .padding(.horizontal)
                .padding(.top, 20)
                
                // Tags list
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(dataModel.uniqueTags().prefix(5), id: \.self) { tag in
                            TagView(tagName: tag)
                        }
                    }
                }

                // Featured restaurants
                VStack {
                    ForEach(dataModel.restaurants.prefix(2), id: \.placeId) { restaurant in
                        FeaturedRestaurantView(restaurant: restaurant, userLocation: userLocation)
                    }
                }
            }
        }
        .onAppear {
            // Fetch user location
        }
    }
}
