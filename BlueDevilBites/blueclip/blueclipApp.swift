//
//  blueclipApp.swift
//  blueclip
//
//  Created by 麻尚 on 2023/11/20.
//

import SwiftUI

@main
struct blueclipApp: App {
    @StateObject private var clipModel = blueclipModel()
//    @StateObject private var resModel = ResDataModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(clipModel)
                .onContinueUserActivity(
                    NSUserActivityTypeBrowsingWeb,
                    perform: handleUserActivity)
           }
    }
    
    func handleUserActivity(_ userActivity: NSUserActivity) {
        print("begin handle")
        guard
            let incomingURL = userActivity.webpageURL,
            let components = URLComponents(
              url: incomingURL,
              resolvingAgainstBaseURL: true),
            let queryItems = components.queryItems
        else {
            clipModel.isFound = false
            return
        }

        guard
            let idValue = queryItems.first(where: { $0.name == "id" })?.value,
            let id = Int(idValue)
        else {
            clipModel.isFound = false
            return
        }
        print("Launching app clip, restaurantId: \(id)")
//        let size = resModel.restaurants.count
//        print("size: \(size)")
        
//        if let res = dataModel.restaurants.first(where: { $0.placeId == id }) {
//            clipModel.selected = res
//            print("find res")
//        }else{
//            clipModel.isFound = false
//        }
    }
}


