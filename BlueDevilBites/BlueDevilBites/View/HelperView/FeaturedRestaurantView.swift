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
            HStack {
                Text(restaurant.name)
                    .bold()
                Spacer()
                Text("\(distanceToRestaurant(from: userLocation, restaurant: restaurant)) mile")
            }
        }
        
    }

    private func distanceToRestaurant(from userLocation: CLLocationCoordinate2D, restaurant: Res) -> Double {
        // Convert string latitude and longitude to CLLocationDegrees
        guard let latitude = CLLocationDegrees(restaurant.position.latitude),
              let longitude = CLLocationDegrees(restaurant.position.longitude) else {
            return 0.0 // Return 0.0 if conversion fails
        }

        // Print the coordinates inside the function
        print("Calculating distance with User Location: \(userLocation.latitude), \(userLocation.longitude)")
        print("Calculating distance with Restaurant Location: \(latitude), \(longitude)")

        
        // Create CLLocation instances for user and restaurant locations
        let restaurantLocation = CLLocation(latitude: latitude, longitude: longitude)
        let currentUserLocation = CLLocation(latitude: userLocation.latitude, longitude: userLocation.longitude)

        // Calculate distance in meters
        let distanceInMeters = currentUserLocation.distance(from: restaurantLocation)

        // Convert meters to miles
        let distanceInMiles = distanceInMeters * 0.000621371

        return distanceInMiles
    }
}

struct FeatureRestaurantImageView: View {
    var restaurant: Res

    var body: some View {
        HStack {
            ForEach(1...3, id: \.self) { index in // Loop from 1 to 3
                Image("\(restaurant.name)_\(index)") // Use the restaurant's name with the index
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120, height: 130)
                    .clipped()
            }
        }
    }
}
