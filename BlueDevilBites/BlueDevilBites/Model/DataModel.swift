//
//  DataModel.swift
//  BlueDevilBites
//
//  Created by Hollen Zhang on 11/6/23.
//

import Foundation
import Combine
import SwiftUI

//let vaporAccessToken = "hz271"
let vaporServerAddress = "127.0.0.1:8080"

let streamerAccessToken = "4fb83524bf2e30e93fd31d18f4143c49"
let sandBoxFileName = "ResData.json"

let streamerDownloadURL = "https://streamer.oit.duke.edu/places/items?tag=west_campus&access_token=\(streamerAccessToken)"

class ResDataModel: ObservableObject {
    @Published var restaurants: [Res] = []
    @Published var comments: [Int: [CommentData]] = [:]
    @Published var searchText: String = ""
    
    var timer: Timer?
    
    init() {
        load()
        download()
        processDownloadedData()
        save()
        let size = restaurants.count
        print("size: \(size)")
        timer = Timer.scheduledTimer(timeInterval: 300, target: self, selector: #selector(updateData), userInfo: nil, repeats: true)
    }
    
    @objc func updateData() {
        download()
        processDownloadedData()
        save()
    }
    
    // Call this function to stop the timer when needed
    func stopUpdatingData() {
        timer?.invalidate()
        timer = nil
    }
    
    func uploadResID() {
        restaurants.forEach { res in
            guard let url = URL(string: "http://\(vaporServerAddress)/restaurants") else { return }

            let resData = ResData(id: res.placeId!)
            guard let uploadData = try? JSONEncoder().encode(resData) else { return }

            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = uploadData

            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let _ = data, error == nil else { return }
                // Handle response or error
            }
            task.resume()
        }
    }

    // Function to fetch comments for each restaurant
    private func fetchComments() {
        for restaurant in restaurants {
            guard let url = URL(string: "http://\(vaporServerAddress)/comments/\(restaurant.placeId!)") else { continue }

            let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
                guard let data = data, error == nil else { return }

                do {
                    let comments = try JSONDecoder().decode([CommentData].self, from: data)
                    DispatchQueue.main.async {
                        self?.comments[restaurant.placeId!] = comments
                    }
                } catch {
                    print("Decoding error: \(error)")
                }
            }
            task.resume()
        }
    }

    // Call this function at the end of the download method
    private func processDownloadedData() {
        print("begin processDownloadedData")
        uploadResID()
        fetchComments()
    }

    func download() {
        print("begin download")
        // Download the basic restaurant data
        guard let url = URL(string: streamerDownloadURL) else { return }

        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let data = data, error == nil else { return }

            // Print the raw data for inspection
//            if let jsonString = String(data: data, encoding: .utf8) {
//                print("Downloaded Restaurant Data: \(jsonString)")
//            }
            
            do {
                let restaurants = try JSONDecoder().decode([Res].self, from: data)
                DispatchQueue.main.async {
                    self?.restaurants = restaurants
                    // Then call processDownloadedData
//                    self?.processDownloadedData()
                }
            } catch {
                print("Decoding error: \(error)")
            }
        }
        task.resume()
        
    }


    func save() {
        print("begin save")
        guard let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent(sandBoxFileName) else { return }

        do {
            let data = try JSONEncoder().encode(restaurants)
            try data.write(to: url)
        } catch {
            print("Saving error: \(error)")
        }
    }

    func load() {
        print("begin load")
        guard let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent(sandBoxFileName) else { return }

        do {
            let data = try Data(contentsOf: url)
            restaurants = try JSONDecoder().decode([Res].self, from: data)
        } catch {
            print("Loading error: \(error)")
        }
    }
    
    func uniqueTags() -> [String] {
        // Debugging: print the count of restaurants
        print("Total restaurants: \(restaurants.count)")

        // Debugging: print tags of each restaurant
        for (index, res) in restaurants.enumerated() {
            print("Restaurant \(index + 1) tags: \(res.tags)")
        }

        let allTags = restaurants.flatMap { $0.tags }
        let uniqueTagsArray = Array(Set(allTags)).sorted()

        // Debugging: print the unique tags
        print("Unique tags: \(uniqueTagsArray)")

        return uniqueTagsArray
    }
    
    func findByName(byName name: String) -> Res? {
        return restaurants.first { $0.name == name }
    }

    func restaurantsWith(tag: String) -> [Res] {
        return restaurants.filter { $0.tags.contains(tag) }
    }
 
    func allRes() -> [Res] {
        return restaurants
    }
    
}
