//
//  RestaurantDetail.swift
//  BlueDevilBites
//
//  Created by Hollen Zhang on 11/14/23.
//

import SwiftUI

struct RestaurantDetail: View {
    @EnvironmentObject var placesDataModel: PlacesDataModel
    @EnvironmentObject var commentsDataModel: CommentsDataModel
    @State private var restaurantToView: Place? = nil
    var body: some View {
        VStack(alignment:.center, spacing: 10) {
//            if let image = restaurantToView.image! {
//                
//            } else {
//                
//            }
        }
    }
}

#Preview {
    RestaurantDetail()
}
