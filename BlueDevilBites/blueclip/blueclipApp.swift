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
        
        downloadRes() { restaurants in
            let size = restaurants.count
            print("Restaurant Size: \(size)")
            if let res = restaurants.first(where: { $0.placeId == id }) {
                clipModel.selectedRes = res
            }else{
                clipModel.isFound = false
            }
            downloadCom(resid: id){ comment in
                clipModel.selectedCom = comment
                print("\(comment)")
                print("comment sizes: \(clipModel.selectedCom.count)")
            }
            print("id: \(clipModel.selectedRes?.placeId)")
            
        }
    }
    
    func downloadRes(completion: @escaping ([Res]) -> Void) {
        guard let url = URL(string: streamerDownloadURL) else { return }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else { return }
            do {
                let restaurants = try JSONDecoder().decode([Res].self, from: data)
//                DispatchQueue.main.async {
//                    resModel.restaurants = restaurants
//                }
                completion(restaurants)
            } catch {
                print("Decoding error: \(error)")
            }
        }
        task.resume()
    }
    
    func downloadCom(resid: Int, completion: @escaping ([CommentData]) -> Void) {
        guard let url = URL(string: "http://\(vaporServerAddress)/comments/\(resid)") else { return }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else { return }

            do {
                let comments = try JSONDecoder().decode([CommentData].self, from: data)
//                DispatchQueue.main.async {
//                    clipModel.selectedCom = comments
//                }
                completion(comments)
            } catch {
                print("Decoding error: \(error)")
            }
        }
        task.resume()
    }
    
}


