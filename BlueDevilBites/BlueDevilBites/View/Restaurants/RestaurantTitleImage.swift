//
//  RestaurantTitleImage.swift
//  BlueDevilBites
//
//  Created by Hollen Zhang on 11/14/23.
//

import SwiftUI

struct RestaurantTitleImage: View {
    var imageName: String

    var body: some View {
        Image(imageName)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .cornerRadius(8)
    }
}

#Preview {
    RestaurantTitleImage(imageName: "Bella Union_1")
}
