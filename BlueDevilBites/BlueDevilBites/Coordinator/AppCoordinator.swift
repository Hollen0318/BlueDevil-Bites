//
//  AppCoordinator.swift
//  BlueDevilBites
//
//  Created by Hollen Zhang on 11/14/23.
//

import Foundation

class AppCoordinator: ObservableObject {
    @Published var showMainView: Bool = false
    
    init() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.showMainView = true
        }
    }
}
