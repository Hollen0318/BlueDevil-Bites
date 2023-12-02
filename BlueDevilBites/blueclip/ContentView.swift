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
        if !model.isDataLoaded {
            ProgressView("Loading...")
        } else if (model.selectedRes == nil){
            Text("can't find restaurant")
        } else {
            ClipRestaurantDetailView()
        }
    }
}

#Preview {
    ContentView()
}
