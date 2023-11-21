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
        if (model.selected != nil) {
            RestaurantDetailView(restaurant: model.selected!)
        } else {
            Text("can't find restaurant")
        }
    }
}

#Preview {
    ContentView()
}
