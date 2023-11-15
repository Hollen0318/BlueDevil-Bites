//
//  FeaturedRestaurantView.swift
//  BlueDevilBites
//
//  Created by Hollen Zhang on 11/15/23.
//

import SwiftUI
import CoreLocation

struct FeaturedRestaurantView: View {
    var restaurant: Res
    var userLocation: CLLocationCoordinate2D

    var body: some View {
        VStack {
            // Assuming you have a function to get images for the restaurant
            FeatureRestaurantImageView(restaurant: restaurant)
            Text(restaurant.name)
                .bold()
            Text("\(distanceToRestaurant(from: userLocation, restaurant: restaurant)) km")
        }
    }

    private func distanceToRestaurant(from userLocation: CLLocationCoordinate2D, restaurant: Res) -> Double {
        // Calculate and return the distance to the restaurant from the user's location
        // For the purpose of this example, we're returning a mock distance
        return 1.5
    }
}

struct FeatureRestaurantImageView: View {
    var restaurant: Res

    var body: some View {
        HStack {
            ForEach(0..<3) { _ in // Replace with actual images
                Image("restaurant_placeholder")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .clipped()
            }
        }
    }
}
