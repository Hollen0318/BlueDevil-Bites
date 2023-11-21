//
//  ContentView.swift
//  blueclip
//
//  Created by 麻尚 on 2023/11/20.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var model: blueclipModel
    var body: some View {
        if (model.selectedRes != nil) {
            RestaurantDetailView(restaurant: model.selectedRes!)
//            Text("id: ")
//            Text(model.selected!.placeIdString)
//            Text("name")
//            Text(model.selected!.name)
        } else {
            Text("can't find restaurant")
        }
    }
}

#Preview {
    ContentView()
}
