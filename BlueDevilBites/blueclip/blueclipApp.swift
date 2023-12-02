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
    var resID : Int = 0
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
        guard
            let incomingURL = userActivity.webpageURL,
            let components = URLComponents(
              url: incomingURL,
              resolvingAgainstBaseURL: true),
            let queryItems = components.queryItems
        else {
            return
        }

        guard
            let idValue = queryItems.first(where: { $0.name == "id" })?.value,
            let id = Int(idValue)
        else {
            return
        }
        clipModel.resID = id
        print("Launching app clip, restaurantId: \(id)")
        downloadRes(resid: clipModel.resID)
        downloadCom(resid: clipModel.resID)
    }
    
    func downloadRes(resid: Int) {
        guard let url = URL(string: streamerDownloadURL) else { return }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else { return }
            do {
                let restaurants = try JSONDecoder().decode([Res].self, from: data)
                DispatchQueue.main.async {
                    if let res = restaurants.first(where: { $0.placeId == resid }) {
                        clipModel.selectedRes = res
                    }
                    clipModel.isDataLoaded = true
                    print("id: \(String(describing: clipModel.selectedRes?.placeId))")
                }
            } catch {
                print("Decoding error: \(error)")
            }
        }
        task.resume()
    }

    func downloadCom(resid: Int) {
        guard let url = URL(string: "http://\(vaporServerAddress)/comments/\(resid)") else { return }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else { return }

            do {
                let comments = try JSONDecoder().decode([CommentData].self, from: data)
                DispatchQueue.main.async {
                    clipModel.selectedCom = comments
                    print("comment sizes: \(clipModel.selectedCom.count)")
                }
            } catch {
                print("Decoding error: \(error)")
            }
        }
        task.resume()
    }
}


