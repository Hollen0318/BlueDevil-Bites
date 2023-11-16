//
//  ContentView.swift
//  BlueDevilBites
//
//  Created by Hollen Zhang on 10/10/23.
//

import SwiftUI
import CoreLocation

struct ContentView: View {
    @EnvironmentObject var resDataModel: ResDataModel
    @State private var isNavigationBarHidden = false
    @State private var isSearching = false  // State to track if search is active

    // Define the default location as CLLocationCoordinate2D
    let defaultLocation = CLLocationCoordinate2D(latitude: 36.0022172, longitude: -78.9385528)

    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                VStack (spacing: 20) {
                    Image("BlueDevilBitesImage")
                        .resizable()
                        .frame(width: geometry.size.width, height: geometry.size.height / 3)
                    
                    SearchBar(text: $resDataModel.searchText, isNavigationBarHidden: $isNavigationBarHidden)
                    
                    ScrollView {
                        ForEach(resDataModel.restaurants, id: \.placeIdString) { featureRes in
                            NavigationLink(destination: RestaurantDetailView(restaurant: featureRes)) {
                                FeaturedRestaurantView(restaurant: featureRes, userLocation: defaultLocation)
                            }
                        }
                    }
                }
            }
            .ignoresSafeArea(edges: .top)
        }
        .navigationBarTitle("")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarHidden(isNavigationBarHidden)
    }
}
