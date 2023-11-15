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
    @State private var isSearching = false  // State to track if search is active

    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                VStack(spacing: -50) {
                    Image("BlueDevilBitesImage")
                        .resizable()
                        .frame(width: geometry.size.width, height: geometry.size.height / 2.5)
                        .ignoresSafeArea(edges: .top)
                    
                    // Search Bar
                    NavigationLink(destination: SearchView(), isActive: $isSearching) {
                        HStack {
                            Image(systemName: "magnifyingglass")
                            Text("Search")
                        }
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(10)
                        .onTapGesture {
                            self.isSearching = true
                        }
                    }
                    .padding()
                    
                    // Additional Padding
                    Spacer().frame(height: 100) // Adjust the height as needed
                    
                    if let mcdonalds = dataModel.findByName(byName: "McDonald's") {
                        FeaturedRestaurantView(restaurant: mcdonalds, userLocation: userLocation)
                            .padding()
                    }
                    
                    // Additional Padding
                    Spacer().frame(height: 100) // Adjust the height as needed
                    
                    if let mcdonalds = dataModel.findByName(byName: "Bella Union") {
                        FeaturedRestaurantView(restaurant: mcdonalds, userLocation: userLocation)
                            .padding()
                    }

                }
            }
        }
        
    }
}
