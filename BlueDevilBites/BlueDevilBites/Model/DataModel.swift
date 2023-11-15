//
//  DataModel.swift
//  BlueDevilBites
//
//  Created by Hollen Zhang on 11/6/23.
//

import Foundation
import Combine
import SwiftUI

let vaporAccessToken = "hz271"
let vaporServerAddress = "1.2.3.4"

let streamerAccessToken = "4fb83524bf2e30e93fd31d18f4143c49"
let sandBoxFileName = "ResData.json"

let streamerDownloadURL = "https://streamer.oit.duke.edu/places/items?tag=west_campus&access_token=\(streamerAccessToken)"

class ResDataModel: ObservableObject {
    @Published var restaurants: [Res] = []
    @Published var comments: [Int: [CommentData]] = [:]

    init() {
        load()
        download()
        save()
    }
    
    func uploadResID() {
            let vaporServerAddress = "1.2.3.4"
            let vaporAccessToken = "hz271"

            restaurants.forEach { res in
                guard let url = URL(string: "http://\(vaporServerAddress)/restaurants?access_token=\(vaporAccessToken)") else { return }

                let resData = ResData(id: res.placeId)
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
                guard let url = URL(string: "http://1.2.3.4/comments/\(restaurant.placeId)&access_token=hz271") else { continue }

                let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
                    guard let data = data, error == nil else { return }

                    do {
                        let comments = try JSONDecoder().decode([CommentData].self, from: data)
                        DispatchQueue.main.async {
                            self?.comments[restaurant.placeId] = comments
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
            uploadResID()
            fetchComments()
        }

    func download() {
        // Download the basic restaurant data
        guard let url = URL(string: streamerDownloadURL) else { return }

        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let data = data, error == nil else { return }

            do {
                let restaurants = try JSONDecoder().decode([Res].self, from: data)
                DispatchQueue.main.async {
                    self?.restaurants = restaurants
                    self?.fetchAdditionalDetails()
                }
            } catch {
                print("Decoding error: \(error)")
            }
        }
        task.resume()
        
        processDownloadedData()

    }

    private func fetchAdditionalDetails() {
        for index in restaurants.indices {
            let restaurant = restaurants[index]
            guard let detailsURL = URL(string: "https://streamer.oit.duke.edu/places/items/index?place_id=\(restaurant.placeId)&access_token=\(streamerAccessToken)") else { continue }

            let task = URLSession.shared.dataTask(with: detailsURL) { [weak self] data, response, error in
                guard let data = data, error == nil else { return }

                do {
                    let additionalDetails = try JSONDecoder().decode(Res.self, from: data)
                    DispatchQueue.main.async {
                        self?.restaurants[index].schedule = additionalDetails.schedule
                        self?.restaurants[index].ownerOperator = additionalDetails.ownerOperator
                        self?.restaurants[index].paymentMethods = additionalDetails.paymentMethods
                    }
                } catch {
                    print("Decoding error: \(error)")
                }
            }
            task.resume()
        }
    }

    func save() {
        guard let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent(sandBoxFileName) else { return }

        do {
            let data = try JSONEncoder().encode(restaurants)
            try data.write(to: url)
        } catch {
            print("Saving error: \(error)")
        }
    }

    func load() {
        guard let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent(sandBoxFileName) else { return }

        do {
            let data = try Data(contentsOf: url)
            restaurants = try JSONDecoder().decode([Res].self, from: data)
        } catch {
            print("Loading error: \(error)")
        }
    }
}
