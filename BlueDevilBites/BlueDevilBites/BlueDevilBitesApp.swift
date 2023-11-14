//
//  BlueDevilBitesApp.swift
//  BlueDevilBites
//
//  Created by Hollen Zhang on 10/10/23.
//

import SwiftUI

@main
struct BlueDevilBitesApp: App {
    @StateObject private var appCoordinator = AppCoordinator()

    var body: some Scene {
            WindowGroup {
                Group {
                    if appCoordinator.showMainView {
                        ContentView()
                            .environmentObject(PlacesDataModel())
                            .environmentObject(CommentsDataModel())
                            .transition(.opacity)
                    } else {
                        LaunchScreen()
                            .environmentObject(PlacesDataModel())
                            .environmentObject(CommentsDataModel())
                            .transition(.opacity)
                    }
                }
                .animation(.easeOut(duration: 0.5), value: appCoordinator.showMainView)
            }
        }
}
